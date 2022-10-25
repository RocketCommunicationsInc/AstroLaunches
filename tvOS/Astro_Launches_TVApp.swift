//
//  Astro_Launches_TVApp.swift
//  Astro Launches TV
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI

@main
struct Astro_Launches_TVApp: App {
    

    init(){
       // _ = DateFormatters() // init the DateFormatters
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear { UIApplication.shared.isIdleTimerDisabled = true } // disables screen saver
        }
    }
}
