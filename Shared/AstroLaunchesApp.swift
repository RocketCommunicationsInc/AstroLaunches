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
        UITableViewCell.appearance().selectedBackgroundView = {
                    let view = UIView()
                    view.backgroundColor = .astroUITableSelectedCell
                    return view
                }()
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchList(networkManager: networkManager)
        }
    }
}
