//
//  ContentView.swift
//  Shared
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI
import AstroSwiftFoundation


struct LaunchList: View {
    @ObservedObject var networkManager: NetworkManager
    @State var showingSettings = false

    var body: some View{
        NavigationView{
            List {
                ForEach(networkManager.launches, id: \.name) { launch in
                    NavigationLink(
                        destination: Text("Destination"),
                        label: {
                            LaunchRow(launch:launch)
                        }).listRowBackground(Color.astroUITableCell)
                }
            }
            .listRowBackground(Color.astroUITableCell)
            //  .listSeparatorStyle(.singleLine, color: .astroUITableSeparator)
            .navigationTitle("Launches")
            .toolbar {
                #if os(iOS) // settings on MacOS handled through Settings object
                ToolbarItem(placement: .automatic)
                {
                    Button(action: {self.showingSettings = true
                    }) {Label("Settings", systemImage: "gear")}
                }
                #endif
            }
        }.sheet(isPresented: $showingSettings) {
            #if os(iOS)

            SettingsView()
            #endif

            }
    }
}

#if os(iOS)

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(Settings.localDataKey) var localData = false // false is unused because we've initialized localDataKey in Settings.init
    @AppStorage(Settings.darkModeKey) var darkMode = false // false is unused because we've initialized localDataKey in Settings.init

    
    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $localData, label: {
                    Text("Use Stored Test Data")
                })
                Toggle(isOn: $darkMode, label: {
                    Text("Always Use Dark Mode")
                })

            }.padding().background(Color.astroUIBackground)
            
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done", action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        }
    }
}
#endif


struct ContentView_Previews: PreviewProvider {
    static var networkManager = NetworkManager()

    static var previews: some View {
        Group {
            LaunchList(networkManager:networkManager).preferredColorScheme(.dark)
        }
    }
}
