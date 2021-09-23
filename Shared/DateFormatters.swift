//
//  DateFormatters.swift
//  Astro Launches
//
//  Created by rocketjeff on 4/2/21.
//

import Foundation

struct DateFormatters
{
    init() {
        _ = ZuluDateFormatter.sharedInstance // init the ZuluDateFormatter
        _ = CountdownDateFormatter.sharedInstance // init the CountdownDateFormatter
        _ = TwentyFourHourTimeFormatter.sharedInstance // init the TwentyFourHourTimeFormatter
    }
}


struct ZuluDateFormatter {
    
    static let sharedInstance = ZuluDateFormatter()
    static var dateFormatter = DateFormatter()
    
    func date(from string: String) -> Date
    {
        // Work around a bug in DateFormatter where a nil date is returned when the string is valid
        // by assigning to an NSDate first, then converting back to Date.
        let intermediateNSDate:NSDate = ZuluDateFormatter.dateFormatter.date(from: string)!as NSDate
        let date:Date = intermediateNSDate as Date
        return date
    }
    
    init() {
        // Set up the particular format that the launch API uses
        ZuluDateFormatter.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        //ZuluDateFormatter.dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    }
}


struct CountdownDateFormatter {
    
    static let sharedInstance = CountdownDateFormatter()
    static var dateFormatter = DateFormatter()
    let now = Date()
    
    func string(from date: Date) -> String
    {
        let offset = date.timeIntervalSince(now)
        let formatter = DateComponentsFormatter()
        let str = formatter.string(from: offset) ?? ""
        return str
    }

    init() {
        CountdownDateFormatter.dateFormatter.dateFormat = "MM dd HH:mm"
    }

}

struct TwentyFourHourTimeFormatter {
    
    static let sharedInstance = TwentyFourHourTimeFormatter()
    static var dateFormatter = DateFormatter()

    func string(from date: Date) -> String
    {
        let str = TwentyFourHourTimeFormatter.dateFormatter.string(from: date)
        return str
    }

    init() {
        TwentyFourHourTimeFormatter.dateFormatter.dateFormat = "HH:mm"
    }

}


struct ShortDateFormatter {
    
    static let sharedInstance = ShortDateFormatter()
    static var dateFormatter = DateFormatter()

    func string(from date: Date) -> String
    {
        let str = ShortDateFormatter.dateFormatter.string(from: date)
        return str
    }

    init() {
        ShortDateFormatter.dateFormatter.dateFormat = "MMMM d"
    }

}

