//
//  Launch.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/29/21.
//

import Foundation
import UIKit


enum Weather{
    case unknown
    case sun
    case clouds
    case rain
}


struct LaunchReply:Decodable{
    let name:String
    let window_start:String?
    let window_end:String?
    let image:String?
}


struct Launch{
    let name:String // the launch mission name, such as "OneWeb-6"
    let windowOpenDate:Date?// the date and time the launch window opens, if known
    let windowEndDate:Date?// the date and time the launch window closes, if known
    let imageURL:URL?
    let image:UIImage?
    

    // Parse a LaunchReply, see which fields were returned and convert to Swift types
    init(_ launchReply:LaunchReply)
    {
        name = launchReply.name

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
        
        if let imageURL = launchReply.image
        {
            self.imageURL = URL(string:imageURL)
        }
        else
        {
            self.imageURL = nil
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
}
