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


    var body: some Scene {
        WindowGroup {
            LaunchList().environmentObject(networkManager)
        }
    }
}
