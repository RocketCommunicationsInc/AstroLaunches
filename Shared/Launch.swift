//
//  Launch.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/29/21.
//

import Foundation
import UIKit
import AstroSwiftFoundation
import MapKit

// The Data Structures found in the JSON //
struct LaunchReply:Decodable{
    let id:String
    let name:String
    let window_start:String?
    let window_end:String?
    let mission:Mission?
    let rocket:Rocket?
    let status:Status?
    let image:String?
    let pad:Pad?
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


// Our Launch Struct that converts the JSON data to Swift types, and checks for missing values
struct Launch: Equatable{
    let id:String
    let missionName:String
    let missionDescription:String
    let rocketName:String
    let windowOpenDate:Date?// the date and time the launch window opens, if known
    let windowEndDate:Date?// the date and time the launch window closes, if known
    let imageURL:URL?
   // let image:UIImage?
    let status:String?
    let astroStatus:AstroStatus
    let padName:String
    let locationName:String
    let locationCoordinate:CLLocationCoordinate2D
    let serviceProviderName:String
    let serviceProviderType:String
    var agency:Agency?
    
    // for equatable conformance, use id
    static public func ==(lhs: Launch, rhs: Launch) -> Bool {
        return lhs.id == rhs.id
    }

    // Parse a LaunchReply, see which fields were returned and convert to Swift types
    init(_ launchReply:LaunchReply)
    {
        id = launchReply.id
        missionName = launchReply.mission?.name ?? "Unknown Mission"
        missionDescription = launchReply.mission?.description ?? "Unknown Mission Description"
        rocketName = launchReply.rocket?.configuration?.name ?? "Unknown Rocket"
        status = launchReply.status?.name ?? nil
        
        if let statusAbbrev = launchReply.status?.abbrev
        {
            astroStatus = Launch.AstroStatusForLaunchStatus(abbreviation: statusAbbrev)
        }
        else
        {
            astroStatus = AstroStatus.Off
        }
        
        // Convert dates using our ZuluDateFormatter, which can handle some peciliaries with this format
        if let date = launchReply.window_start
        {
            windowOpenDate = ZuluDateFormatter.sharedInstance.date(from: date)
        }
        else
        {
            windowOpenDate = nil
        }
        
        if let date = launchReply.window_end
        {
            windowEndDate = ZuluDateFormatter.sharedInstance.date(from: date)
        }
        else
        {
            windowEndDate = nil
        }
        
        if let replyImageURL = launchReply.image
        {
            imageURL = URL(string:replyImageURL) ?? nil
        }
        else
        {
            imageURL = nil
        }
        
        padName = launchReply.pad?.name ?? "Unknown Pad Name"
        locationName = launchReply.pad?.name ?? "Unknown Location Name"
        serviceProviderName = launchReply.launch_service_provider?.name ?? "Unknown Provider Name"
        serviceProviderType = launchReply.launch_service_provider?.type ?? "Unknown Type"
        
        let latitudeCoordinate = Double(launchReply.pad?.latitude ?? "31.422878000000000")
        let longitudeCoordinate = Double(launchReply.pad?.longitude ?? "-122.009_020")
        locationCoordinate = CLLocationCoordinate2D(latitude: latitudeCoordinate ?? -122.009_020 , longitude: longitudeCoordinate ?? 31.422878000000000)

        if let agencyURL = launchReply.launch_service_provider?.url
        {
            do {
                let data = try Data(contentsOf: agencyURL)
                let theAgency = try! JSONDecoder().decode(AgencyReply.self, from: data)
                agency = Agency(theAgency)
            } catch  {
                agency = nil
            }

        }
 //       self.agency = nil
        
//        if let agencyURL = launchReply.launch_service_provider?.dataURL
//        {
//            URLSession.shared.dataTask(with: agencyURL) { (data,_ , _) in
//                guard let data = data else {return}
//                let theAgency = try! JSONDecoder().decode(AgencyReply.self, from: data)
//                DispatchQueue.main.async {
//                    // post process Agency
//                    self.agency = Agency(theAgency)
//                }
//            }.resume()
//        }
    }
    
    static func AstroStatusForLaunchStatus(abbreviation:String)->AstroStatus
    {
        switch abbreviation {
        case "TBD","TBC":
            return AstroStatus.Standby
        case "Go":
            return AstroStatus.Normal
        default:
            return AstroStatus.Off
        }
    }
}

    
    struct Agency:Decodable{
        let id:Int
        let name:String
        let logoURL:URL?
        
        // Parse a LaunchReply, see which fields were returned and convert to Swift types
        init(_ agencyReply:AgencyReply)
        {
            id = agencyReply.id
            name = agencyReply.name ?? "Unknown Agency Name"

            if let replyLogoURL = agencyReply.logo_url
            {
                logoURL = URL(string:replyLogoURL) ?? nil
            }
            else
            {
                logoURL = nil
            }
        }
    }


