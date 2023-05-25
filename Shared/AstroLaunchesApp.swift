//
//  Astro_LaunchesApp.swift
//  Shared
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI

@main

struct Astro_LaunchesApp: App {

    @StateObject var networkManager = NetworkManager(timePeriods: [.upcoming,.recent])

    init(){
        
#if os(iOS)
        // allow background colors set by List's .background modifier to work in grouped configurations in light mode
        UITableView.appearance().backgroundColor = .clear // *** Astro customization
#endif
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(networkManager: networkManager)
        }

#if os(macOS)
        Settings {
            SettingsView()
        }
#endif
    }
}
