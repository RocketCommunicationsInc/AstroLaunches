//
//  Astro_LaunchesApp.swift
//  Astro Launches WatchKit Extension
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI

@main
struct Astro_LaunchesApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
