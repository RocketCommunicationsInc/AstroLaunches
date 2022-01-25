//
//  SettingsView.swift
//  Astro Launches (iOS)
//
//  Created by rocketjeff on 1/7/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(Settings.localDataKey) var localData = false // false is unused because we've initialized localDataKey in Settings.init
//    @AppStorage(Settings.darkModeKey) var darkMode = false // false is unused because we've initialized darkMode in Settings.init

    
    var body: some View {
        NavigationView {
            Form {
                #if DEBUG // only show the stored test data option on debug builds, not testflight or store builds
                Toggle(isOn: $localData, label: {
                    Text("Use Stored Test Data")
                })
                #endif
//                Toggle(isOn: $darkMode, label: {
//                    Text("Always Use Dark Mode")
//                })
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
