//
//  DateFormatters.swift
//  Astro Launches
//
//  Created by rocketjeff on 4/2/21.
//

import Foundation

//struct DateFormatters
//{
//    init() {
////        _ = ZuluDateFormatter.sharedInstance // init the ZuluDateFormatter
////       // _ = CountdownDateFormatter.sharedInstance // init the CountdownDateFormatter
////        _ = TwentyFourHourTimeFormatter.sharedInstance // init the TwentyFourHourTimeFormatter
////        _ = ShortDateFormatter.sharedInstance // init the ShortDateFormatter
//    }
//}


struct ZuluDateFormatter {
    
    static let sharedInstance = ZuluDateFormatter()
    static let dateFormatter = DateFormatter()
    
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
    }
}



struct TwentyFourHourTimeFormatter {
    
    static let sharedInstance = TwentyFourHourTimeFormatter()
    static let dateFormatter = DateFormatter()

    func string(from date: Date) -> String
    {
        let str = TwentyFourHourTimeFormatter.dateFormatter.string(from: date)
        return str
    }

    init() {
        TwentyFourHourTimeFormatter.dateFormatter.dateFormat = "HH:mm"
    }
}

// Return a formatter for the abbreviated form used in some Launches displays
struct ShortDateFormatter {
    
    static let sharedInstance = ShortDateFormatter()
    static let dateFormatter = DateFormatter()

    func string(from date: Date) -> String
    {
        let str = ShortDateFormatter.dateFormatter.string(from: date)
        return str
    }

    init() {
        ShortDateFormatter.dateFormatter.dateFormat = "MMMM d"
    }
}

// Return a formatter to extract only the day
struct DayFormatter {
    
    static let sharedInstance = DayFormatter()
    static let dayFormatter = DateFormatter()
    
    func string(from date: Date) -> String
    {
        let str = DayFormatter.dayFormatter.string(from: date)
        return str
    }
    
    init() {
        DayFormatter.dayFormatter.dateFormat = "dd"
    }
}

// Return a formatter to extract only the hour
struct HourFormatter {
    
    static let sharedInstance = HourFormatter()
    static let hourFormatter = DateFormatter()
    
    func string(from date: Date) -> String
    {
        let str = HourFormatter.hourFormatter.string(from: date)
        return str
    }
    
    init() {
        HourFormatter.hourFormatter.dateFormat = "hh"
    }
}

// Return a formatter to extract only the minute
struct MinuteFormatter {
    
    static let sharedInstance = MinuteFormatter()
    static let hourFormatter = DateFormatter()
    
    func string(from date: Date) -> String
    {
        let str = MinuteFormatter.hourFormatter.string(from: date)
        return str
    }
    
    init() {
        MinuteFormatter.hourFormatter.dateFormat = "mm"
    }
}

// Return a formatter to extract only the second
struct SecondFormatter {
    
    static let sharedInstance = SecondFormatter()
    static let secondFormatter = DateFormatter()
    
    func string(from date: Date) -> String
    {
        let str = SecondFormatter.secondFormatter.string(from: date)
        return str
    }
    
    init() {
        SecondFormatter.secondFormatter.dateFormat = "ss"
    }
}
