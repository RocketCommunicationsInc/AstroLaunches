//
//  ZuluDateFormatter.swift
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
    }

}
struct ZuluDateFormatter {
    
    static let sharedInstance = ZuluDateFormatter()
    static var dateFormatter = DateFormatter()
    
    func date(from string: String) -> Date
    {
        // Work around a bug in DateFormatter where a nil date is returned when the string is valid
        // by assigning to an NSDate first, then converting back to Date.
        let preciseNSDate:NSDate = ZuluDateFormatter.dateFormatter.date(from: string)!as NSDate
        let preciseDate:Date = preciseNSDate as Date
   //     print(preciseDate)
        return preciseDate
    }
    
    init() {
        // Set up the particular format that the launch API uses
        ZuluDateFormatter.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mmZ"
        //ZuluDateFormatter.dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    }
}


struct CountdownDateFormatter {
    
    static let sharedInstance = CountdownDateFormatter()
    static var dateFormatter = DateFormatter()

    func string(from date: Date) -> String
    {
        let str = CountdownDateFormatter.dateFormatter.string(from: date)
        return str
    }

    init() {
        // Set up the particular format that the launch API uses
        CountdownDateFormatter.dateFormatter.dateFormat = "MM dd HH:mm"
        //ZuluDateFormatter.dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    }

}
