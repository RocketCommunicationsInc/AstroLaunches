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
    }
    
    var body: some Scene {
        WindowGroup {
            if (Settings.darkMode)
            {
                LaunchList(networkManager: networkManager).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/) // need to find a way to observe changes to dark mode and react. Possibly by pushing this down a level to LaunchList?
            }
            else
            {
                LaunchList(networkManager: networkManager)
            }
        }
    }
}
