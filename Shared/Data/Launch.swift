//
//  Launch.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/29/21.
//

import Foundation
import AstroSwiftFoundation
import MapKit

// Representing a single Launch, the central data type of the application

// Structs that mirror the Data Structures found in the response JSON
// Property names must match json element names exactly, and be optional if presense in the json is not assured
// This allows JSONDecoder().decode to do most of the decoding work
struct LaunchReply:Decodable{
    let id:String
    let name:String?
    let window_start:String?
    let window_end:String?
    let mission:Mission?
    let rocket:Rocket?
    let status:Status?
    let image:String?
    let pad:Pad?
    let webwebcast_live:Bool?
    let vidURLs:[VidURL]?
    let launch_service_provider:LaunchServiceProvider?
}

struct AgencyReply:Decodable{
    let id:Int
    let name:String?
    let logo_url:String?
}

struct Mission:Decodable{
    let name:String?
    let description:String?
    let type:String?
}

struct Status:Decodable{
    let name:String?
    let abbrev:String?
}

struct Pad:Decodable{
    let name:String?
    let latitude:String?
    let longitude:String?
}

struct VidURL:Decodable{
    let priority:Int?
    let title:String?
    let description:String?
    let feature_image:String?
    let url:String?
}

//struct PadLocation:Decodable{
//    let name:String
//}

struct Rocket:Decodable{
    let id:Int
    let configuration:RocketConfiguration?
}

struct RocketConfiguration:Decodable{
    let name:String?
}

struct LaunchServiceProvider:Decodable{
    let name:String?
    let type:String?
    let url:URL?
}

//
// Our Launch struct that represents the original JSON data as Swift types, and checks for missing values
//
class Launch: Equatable, Hashable{
    let id:String // a unique ID, always present
    let missionName:String
    let missionDescription:String
    let rocketName:String
    let windowOpenDate:Date?// the date and time the launch window opens, if known
    let windowEndDate:Date?// the date and time the launch window closes, if known
    let imageURL:URL?
    let status:String?
    let astroStatus:AstroStatus
    let padName:String
    let locationName:String
    let locationCoordinate:CLLocationCoordinate2D
    let serviceProviderName:String
    let serviceProviderType:String
    var agency:Agency?
    let webcast:Bool
    let videoURL:URL?
    
    // for equatable conformance, use id
    static public func ==(lhs: Launch, rhs: Launch) -> Bool {
        return lhs.id == rhs.id
    }
    
    // for hashable conformance, use id
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }

    // Parse a LaunchReply, see which fields were returned and convert to Swift types
    init(_ launchReply:LaunchReply)
    {
        id = launchReply.id
        missionName = launchReply.mission?.name ?? "Unknown Mission"
        missionDescription = launchReply.mission?.description ?? "Unknown Mission"
        rocketName = launchReply.rocket?.configuration?.name ?? "Unknown Rocket"
        status = launchReply.status?.name ?? nil
        
        if let statusAbbrev = launchReply.status?.abbrev {
            astroStatus = Launch.AstroStatusForLaunchStatus(abbreviation: statusAbbrev)
        } else {
            astroStatus = AstroStatus.off
        }
        
        // Convert dates using our ZuluDateFormatter, which can handle some peciliaries with this format
        if let date = launchReply.window_start {
            windowOpenDate = ZuluDateFormatter.sharedInstance.date(from: date) }
        else {
            windowOpenDate = nil
        }
        
        if let date = launchReply.window_end {
            windowEndDate = ZuluDateFormatter.sharedInstance.date(from: date)
        } else {
            windowEndDate = nil
        }
        
        if let replyImageURL = launchReply.image {
            imageURL = URL(string:replyImageURL) ?? nil
        } else {
            imageURL = nil
        }
        
        padName = launchReply.pad?.name ?? "Unknown Pad"
        locationName = launchReply.pad?.name ?? "Unknown Location"
        serviceProviderName = launchReply.launch_service_provider?.name ?? "Unknown Provider"
        serviceProviderType = launchReply.launch_service_provider?.type ?? "Unknown Type"
        
        let latitudeCoordinate = Double(launchReply.pad?.latitude ?? "31.422878000000000")
        let longitudeCoordinate = Double(launchReply.pad?.longitude ?? "-122.009_020")
        locationCoordinate = CLLocationCoordinate2D(latitude: latitudeCoordinate ?? -122.009_020 , longitude: longitudeCoordinate ?? 31.422878000000000)

        
        // webcast_live is non-nil and true if live video is availabl
        if let webwebcast_live = launchReply.webwebcast_live {
            webcast = webwebcast_live
        } else {
            webcast = false
        }
        
        // vidURLs is an array of associated videos, we're only interested in the first one, if it exists.
        if let urls = launchReply.vidURLs {// if the array was returned
            if let first = urls.first?.url { // if there is a first entry that has a URL
                videoURL = URL(string:first) ?? nil // if it us a proper URL, set videoURL
            } else {
                videoURL = nil
            }
        } else {
            videoURL = nil
        }
        
        // fetching the agency requires another web request, start that on another thread
        self.agency = nil
        if let agencyURL = launchReply.launch_service_provider?.url
        {
            URLSession.shared.dataTask(with: agencyURL) { data, urlResponse, error in
                if let _ = error {
                    return // don't show an error, the agency will just remain nil
                }

                let response = urlResponse as! HTTPURLResponse
                let status = response.statusCode
                guard (200...299).contains(status) else {
                    return  // don't show an error, the agency will just remain nil
                }

                guard let data = data else {
                    // handle zero data error
                    return  // don't show an error, the agency will just remain nil
                }

                let theAgency = try! JSONDecoder().decode(AgencyReply.self, from: data)
                self.agency = Agency(theAgency)
            }.resume()
        }
    }
    
    // Convert API Status to Astro Status
    static func AstroStatusForLaunchStatus(abbreviation:String)->AstroStatus
    {
        switch abbreviation {
        case "TBD","TBC":
            return AstroStatus.standby
        case "Go","Success":
            return AstroStatus.normal
        case "Failure":
            return AstroStatus.caution
        default:
            return AstroStatus.off
        }
    }
}

    
    struct Agency:Decodable{
        let id:Int
        let name:String
        let logoURL:URL?
        
        // Parse a AgencyReply, see which fields were returned and convert to Swift types
        init(_ agencyReply:AgencyReply) {
            id = agencyReply.id
            name = agencyReply.name ?? "Unknown Agency"

            if let replyLogoURL = agencyReply.logo_url {
                logoURL = URL(string:replyLogoURL) ?? nil
            } else {
                logoURL = nil
            }
        }
    }


