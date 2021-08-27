//
//  Settings.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/22/21.
//

import Foundation

struct Settings {
    
    static let sharedInstance = Settings()
    
    // localData and darkMode are UserDefaults that are accessed through $AppStorage in SwitftUI views
    // or through get-only properties (below)where $AppStorage is not allowed
    static let localDataKey = "localData"
    static let darkModeKey = "darkMode"

    // Create a get-only property for accessing localData where $AppStorage is not allowed
    static var localData:Bool {
            return UserDefaults.standard.bool(forKey: Settings.localDataKey)
        }
    
//    // Create a get-only property for accessing darkMode where $AppStorage is not allowed
//    static var darkMode:Bool {
//            return UserDefaults.standard.bool(forKey: Settings.darkModeKey)
//        }
    
    // Do one-time init of these defaults at program start. This means that initial values set in view $AppStorage is ignored.
    init() {
        UserDefaults.standard.register(defaults: [
            Settings.localDataKey: false,
            Settings.darkModeKey: true,

        ])
    }
}
