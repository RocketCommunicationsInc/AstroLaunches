//
//  AstroLaunchesApp.swift
//  Astro Launches TV
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI

@main
struct AstroLaunchesApp: App {
    @StateObject var networkManager = NetworkManager(timePeriods: [.upcoming])
    @Environment(\.scenePhase) var scenePhase

    init(){
    }
    var body: some Scene {
        WindowGroup {
            ContentView(networkManager:networkManager)
                .onAppear { UIApplication.shared.isIdleTimerDisabled = true } // disables screen saver
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
