//
//  AstroLaunchesApp.swift
//  Astro Launches TV
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI

@main
struct AstroLaunchesApp: App {
    
    init(){
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear { UIApplication.shared.isIdleTimerDisabled = true } // disables screen saver
        }
    }
}
