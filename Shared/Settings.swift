//
//  Settings.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/22/21.
//

import Foundation

struct Settings {
    
    static let sharedInstance = Settings()
    
    static let localDataKey = "localData"
    static let preferDarkMode = "preferDarkMode"

    
    static var localData:Bool {
        get {
            return UserDefaults.standard.bool(forKey: Settings.localDataKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Settings.localDataKey)
        }
    }
    init() {
        UserDefaults.standard.register(defaults: [
            Settings.localDataKey: false,
            Settings.preferDarkMode: true,

        ])
    }
}
