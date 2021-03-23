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
        
        // customize the app-wide navgation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .astroUIBar
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchList(networkManager: networkManager)
        }
    }
}
