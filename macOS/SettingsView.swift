//
//  SettingsView.swift
//
//  Created by Jeff Hokit on 10/21/22.
//

import SwiftUI

/// SettingsView used by the Settings scene on macOS
struct SettingsView: View {
    @AppStorage(colorSchemeAutomaticName) var colorSchemeAutomatic:ColorSchemeAutomatic = .dark
    
    var body: some View {
        SettingFormContents()
            .padding(20)
            .frame(width: 350, height: 100) // the Mac dialog size. It's not automatic
            .preferredColorScheme(colorSchemeAutomatic == .light ? .light : colorSchemeAutomatic == .dark ? .dark : nil)
    }
}

func SettingFormContents() -> some View {
    @AppStorage(colorSchemeAutomaticName) var colorSchemeAutomatic:ColorSchemeAutomatic = .automatic
    
    return Form{
        Picker(selection: $colorSchemeAutomatic, label: Text("Appearance")) {
            Text("Light").tag(ColorSchemeAutomatic.light)
            Text("Dark").tag(ColorSchemeAutomatic.dark)
            Text("Auto").tag(ColorSchemeAutomatic.automatic)
        }.pickerStyle(SegmentedPickerStyle())
    }
}
