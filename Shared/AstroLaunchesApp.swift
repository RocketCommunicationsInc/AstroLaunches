//
//  Astro_LaunchesApp.swift
//  Shared
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI

@main


struct Astro_LaunchesApp: App {

    @StateObject var networkManager = NetworkManager()

    init(){
        _ = Settings.sharedInstance // init the Settings
        _ = DateFormatters() // init the DateFormatters
//        _ = CountdownDateFormatter.sharedInstance // init the CountdownDateFormatter

        #if os(iOS)
        // customize the app-wide navgation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .astroUIBar
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        
        // customize the app-wide List (UITableView) appearance
        UITableView.appearance().backgroundColor = .astroUIBackground
        #endif

//        let dateString = "2021-04-07T16:34Z"
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mmZ"
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
//
//        //dateFormatter.formatOptions = [.withInternetDateTime,.withDashSeparatorInDate,.withColonSeparatorInTime]
//        let preciseNSDate:NSDate = dateFormatter.date(from: dateString)!as NSDate
//        let preciseDate:Date = preciseNSDate as Date
//        print(ZuluDateFormatter.sharedInstance.date(from: dateString))

    }
    
    var body: some Scene {
        WindowGroup {
            LaunchList(networkManager: networkManager)
        }
    }
}
