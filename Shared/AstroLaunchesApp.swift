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
    @Environment(\.scenePhase) var scenePhase

    init(){
        
#if os(iOS)
        // allow background colors set by List's .background modifier to work in grouped configurations in light mode
        UITableView.appearance().backgroundColor = .clear // *** Astro customization
#endif
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(networkManager: networkManager)
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .active {
                        // refresh each time the app is activated, in case the cached data is stale
                        // if the cache is good, this call is inexpensive and will not change the data
                        networkManager.refreshLaunches()
                    }
                }
        }


#if os(macOS)
        Settings {
            SettingsView()
        }
#endif
    }
}
