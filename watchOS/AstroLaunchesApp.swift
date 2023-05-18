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

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(networkManager: networkManager).tint(.astroUIAccent).accentColor(.astroUIAccent)//  must also set tint color in Assets
            }
        }
    }
}
