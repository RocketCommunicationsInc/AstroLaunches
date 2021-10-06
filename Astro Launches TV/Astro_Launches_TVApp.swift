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

    init(){
        _ = DateFormatters() // init the DateFormatters
    }

    var body: some Scene {
        WindowGroup {
            ConferenceRoomView(networkManager: networkManager)
        }
    }
}
