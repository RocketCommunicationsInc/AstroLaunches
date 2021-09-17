//
//  Launch.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/29/21.
//

import Foundation


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
//    let weather_temp:Float?
//    let weather_icon:String?
//    let win_open:String?
//    let win_close:String?
}





struct Launch{
    let name:String // the launch mission name, such as "OneWeb-6"
    let windowOpenDate:Date?// the date and time the launch window opens, if known
    let windowEndDate:Date?// the date and time the launch window closes, if known
    let image:URL?
//    let temperature:Float? // the forecast temperature at launch, in farenheit, if known
//    let weather:Weather? // an enum of basic weather conditions
   // let win_open:String?
    


    // Parse a LaunchReply, see which fields were returned and convert to Swift types
    init(_ launchReply:LaunchReply)
    {
        name = launchReply.name
 //       temperature  = launchReply.weather_temp
        
//        // weather_icon is one of these icon values, https://erikflowers.github.io/weather-icons/
//        // Simplify and map down to our Weather enum
//        if let weatherIcon = launchReply.weather_icon
//        {
//            if weatherIcon.contains("cloud")
//            {
//                weather = .clouds
//            }
//            else if weatherIcon.contains("rain")
//            {
//                weather = .rain
//            }
//            else if weatherIcon.contains("sun")
//            {
//                weather = .sun
//            }
//            else
//            {
//                weather = .unknown
//            }
//        }
//        else
//        {
//            weather = nil
//        }

        // Convert dates using our ZuluDateFormatter, which can handle some peciliaries with this format

        // t0 = The date and time of the planned launch time (T-0) in ISO 8601 format
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
        

        image = nil
    }
}
