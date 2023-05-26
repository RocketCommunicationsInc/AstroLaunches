//
//  Astro_LaunchesApp.swift
//  Astro Launches Watch App
//
//  Created by Jeff Hokit on 9/16/22.
//

import SwiftUI

@main
struct AstroLaunchesApp: App {
    @StateObject var networkManager = NetworkManager(timePeriods: [.upcoming])
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(networkManager: networkManager)
                    .tint(.astroUIAccent)
                    .accentColor(.astroUIAccent)//  must also set tint color in Assets
                    .onChange(of: scenePhase) { newPhase in
                        if newPhase == .active {
                            // refresh each time the app is activated, in case the cached data is stale
                            // if the cache is good, this call is inexpensive and will not change the data
                            networkManager.refreshLaunches()
                        }
                    }

            }
        }
    }
}
