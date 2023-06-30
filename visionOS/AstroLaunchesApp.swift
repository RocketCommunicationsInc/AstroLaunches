//
//  Astro_LaunchesApp.swift
//  Astro Launches
//
//  Created by Jeff Hokit on 6/22/23.
//

import SwiftUI

@main
struct Astro_LaunchesApp: App {
    @StateObject var networkManager = NetworkManager(timePeriods: [.upcoming])
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView(networkManager: networkManager)
                .onChange(of: scenePhase) { oldState, newState in
                    if newState == .active {
                        // refresh each time the app is activated, in case the cached data is stale
                        // if the cache is good, this call is inexpensive and will not change the data
                        networkManager.refreshLaunches()
                    }
                }
            
        }
    }
}
