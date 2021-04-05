//
//  Astro_Launches_TVApp.swift
//  Astro Launches TV
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI

@main
struct Astro_Launches_TVApp: App {
    @StateObject var networkManager = NetworkManager()

    var body: some Scene {
        WindowGroup {
            ContentView(networkManager: networkManager)
        }
    }
}
