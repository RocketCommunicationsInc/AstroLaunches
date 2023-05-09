//
//  Astro_LaunchesApp.swift
//  Astro Launches Watch App
//
//  Created by Jeff Hokit on 9/16/22.
//

import SwiftUI

@main
struct AstroLaunchesApp: App {
    @StateObject var networkManager = NetworkManager()

    var body: some Scene {
        WindowGroup {
            ContentView(networkManager: networkManager)
        }
    }
}
