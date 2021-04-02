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


struct Launch{
    let name:String // the launch mission name, such as "OneWeb-6"
    let date:String // the rough date, in no particular format. May be a day or a month
    let preciseDate:Date?// the exact expected launch date and time, if known
    let windowOpenDate:Date?// the date and time the launch window opens, if known
    let windowCloseDate:Date?// the date and time the launch window closes, if known
    let temperature:Float? // the forecast temperature at launch, in farenheit, if known
    let weather:Weather? //
   // let win_open:String?
    
    //let dateFormatter = ISO8601DateFormatter()


    
    init(_ launchReply:LaunchReply)
    {
        // setup date formatter
       // dateFormatter.formatOptions = [.withInternetDateTime,.withDashSeparatorInDate,.withColonSeparatorInTime]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"

        name = launchReply.name
        date  = launchReply.date_str
        temperature  = launchReply.weather_temp
        
        if let weatherIcon = launchReply.weather_icon
        {
            if weatherIcon.contains("cloud")
            {
                weather = .clouds
            }
            else if weatherIcon.contains("rain")
            {
                weather = .rain
            }
            else if weatherIcon.contains("sun")
            {
                weather = .sun
            }
            else
            {
                weather = .unknown
            }
        }
        else
        {
            weather = nil
        }

        if let t0date = launchReply.t0
        {
            preciseDate = ZuluDateFormatter.sharedInstance.date(from: t0date)

        }
        else
        {
            preciseDate = nil
        }
        
        if let windowOpen = launchReply.win_open
        {
            let thewindowOpenDate = ZuluDateFormatter.sharedInstance.date(from: windowOpen)
            windowOpenDate = thewindowOpenDate
        }
        else
        {
            windowOpenDate = nil
        }
        
        if let windowClose = launchReply.win_close
        {
            windowCloseDate = ZuluDateFormatter.sharedInstance.date(from: windowClose)
        }
        else
        {
            windowCloseDate = nil
        }
        
        
    }
}
