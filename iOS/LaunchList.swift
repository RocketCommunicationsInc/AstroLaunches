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
                    ColorSchemeAutomaticToolbarContent()
                    #if os(iOS) // settings on MacOS handled through Settings object
//                    ToolbarItem(placement: .automatic)
//                    {
//                        Button(action: {self.showingSettings = true
//                        }) {Label("Settings", systemImage: "gear")}
//                    }
                    #endif
            }
            }
        }.alert(String(networkManager.alertTitle), isPresented: $networkManager.isShowingNetworkAlert){
            Button("Continue", role: .cancel) {}
        } message: {
            Text(networkManager.alertMessage)
        }
        .sheet(isPresented: $showingSettings) {
            #if os(iOS)
            SettingsView()
            #endif
            }
        .modifier(colorSchemeAutomatic())

    }
}


struct ContentView_Previews: PreviewProvider {
    static var networkManager = NetworkManager()

    static var previews: some View {
        Group {
            LaunchList(networkManager:networkManager).preferredColorScheme(.dark)
        }
    }
}
