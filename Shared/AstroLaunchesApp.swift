//
//  Astro_LaunchesApp.swift
//  Shared
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI

@main
struct Astro_LaunchesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
