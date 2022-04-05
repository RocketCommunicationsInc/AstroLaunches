//
//  SettingsView.swift
//  Astro Launches (iOS)
//
//  Created by rocketjeff on 1/7/22.
//

import SwiftUI

// Not used right now, left behind for possible reuse later

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(Settings.localDataKey) var localData = false

    
    var body: some View {
        NavigationView {
            Form {
                #if DEBUG // only show the stored test data option on debug builds, not testflight or store builds
                Toggle(isOn: $localData, label: {
                    Text("Use Stored Test Data")
                })
                #endif
            }
            .padding(.top,8)
            .background(Color.astroUIBackground)
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done", action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
