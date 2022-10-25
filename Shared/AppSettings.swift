//
//  AppSettings.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/22/21.
//

import Foundation

struct AppSettings {
    
    static let sharedInstance = AppSettings()
    
    // localData and darkMode are UserDefaults that are accessed through $AppStorage in SwitftUI views
    // or through get-only properties (below)where $AppStorage is not allowed
    static let localDataKey = "localData"

    // Create a get-only property for accessing localData where $AppStorage is not allowed
    static var localData:Bool {
            return UserDefaults.standard.bool(forKey: AppSettings.localDataKey)
        }
    

    
    // Do one-time init of these defaults at program start. This means that initial values set in view $AppStorage is ignored.
    init() {
        UserDefaults.standard.register(defaults: [
            AppSettings.localDataKey: false,

        ])
    }
}
