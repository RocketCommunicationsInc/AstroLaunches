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

    @AppStorage(Settings.darkModeKey) var darkMode = false // false is unused because we've initialized darkMode in Settings.init
    @Environment(\.colorScheme) var systemColorScheme

    var body: some View{
        NavigationView{
            ScrollView {
                LazyVStack() {
                    ForEach(networkManager.launches, id: \.id) { launch in
                        NavigationLink(
                            destination: LaunchDetail(launch: launch),
                            label: {
                                LaunchRow(launch:launch)
                                    .padding(.top,3)
                                    .padding(.bottom,3)
                                    .padding(.leading,6)
                                    .padding(.trailing,6)
                            }).listRowBackground(Color.astroUITableCell)
                    }
                }
                .listRowBackground(Color.astroUITableCell)
                // to-do: add list separator color here for iOS 15
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
            }
        }.conditionalModifier(darkMode, ForceDarkMode())
        .sheet(isPresented: $showingSettings) {
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
    @AppStorage(Settings.darkModeKey) var darkMode = false // false is unused because we've initialized darkMode in Settings.init

    
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
