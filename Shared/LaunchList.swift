//
//  ContentView.swift
//  Shared
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI
import CoreData
import AstroSwiftFoundation
#if os(iOS)
import SwiftUIListSeparator
#endif

//import Combine


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
                        })
                }
            }
            .listRowBackground(Color.astroUITableCell)
            //  .listSeparatorStyle(.singleLine, color: .astroUITableSeparator)
            .navigationTitle("Launches")
            .toolbar {
    
                ToolbarItem(placement: .automatic)
                {
                    Button(action: {self.showingSettings = true
                    }) {Label("Settings", systemImage: "gear")}
                }

            }
        }.sheet(isPresented: $showingSettings) {
            SettingsView()}
    }
}

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(Settings.localDataKey) var localData = Settings.localData
    
    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $localData, label: {
                    Text("Use Stored Test Data")
                })
                
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done", action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Text("placeholder")
        //LaunchList().preferredColorScheme(.dark)
    }
}
