//
//  Launch.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/29/21.
//

import Foundation
import UIKit
import AstroSwiftFoundation

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
}

struct Mission:Decodable{
    let name:String
    let description:String?
    let type:String?
//    let type:String?
}

struct Status:Decodable{
    let name:String
    let abbrev:String?
}

struct Rocket:Decodable{
    let id:Int
    let configuration:RocketConfiguration?
}

struct RocketConfiguration:Decodable{
    let name:String
}

// Our Launch Struct that converts the JSON data to Swift types, and checks for missing values
struct Launch{
    let id:String
    let missionName:String
    let missionDescription:String
    let rocketName:String
    let windowOpenDate:Date?// the date and time the launch window opens, if known
    let windowEndDate:Date?// the date and time the launch window closes, if known
    let imageURL:URL?
    let image:UIImage?
    let status:String?
    let astroStatus:AstroStatus
    
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
        

        if (imageURL != nil)
        {
            do {
                let data = try Data(contentsOf: imageURL!)
                self.image = UIImage(data:data)
            } catch  {
                image = nil
            }
        }
        else
        {
            image = nil
        }
        
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

