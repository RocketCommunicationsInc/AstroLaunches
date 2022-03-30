//
//  LaunchList.swift
//  Shared
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI
import AstroSwiftFoundation


struct LaunchList: View {
    @ObservedObject var networkManager: NetworkManager
 //   @State var showingSettings = false

    // the main view on iPhone, or sidebar on iPad
    var body: some View{
        TabView {
            UpcomingLaunches(networkManager: networkManager)
            PastLaunches(networkManager: networkManager)
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

struct UpcomingLaunches: View {
    @ObservedObject var networkManager: NetworkManager

    var body: some View {
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
                .navigationTitle("Upcoming")
                .toolbar {
                    ColorSchemeAutomaticToolbarContent()
                    
                }
            }
        }
        .tabItem {
            Label("Upcoming", systemImage: "clock")}
        .alert(String(networkManager.alertTitle), isPresented: $networkManager.isShowingNetworkAlert){
            Button("Continue", role: .cancel) {}
        } message: {
            Text(networkManager.alertMessage)
        }
//        .sheet(isPresented: $showingSettings) {
//#if os(iOS)
//            SettingsView()
//#endif
//        }
        .modifier(colorSchemeAutomatic())
    }
}


    struct PastLaunches: View {
        @ObservedObject var networkManager: NetworkManager
        
        var body: some View {
            NavigationView{
                ScrollView {
                    LazyVStack() {
                        ForEach(networkManager.pastLaunches, id: \.id) { launch in
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
                    .navigationTitle("Past")
                    .toolbar {
                        ColorSchemeAutomaticToolbarContent()
                        
                    }
                }
            }
            .tabItem {
                Label("Past", systemImage: "clock.arrow.circlepath")}
            .alert(String(networkManager.alertTitle), isPresented: $networkManager.isShowingNetworkAlert){
                Button("Continue", role: .cancel) {}
            } message: {
                Text(networkManager.alertMessage)
            }
            //        .sheet(isPresented: $showingSettings) {
            //#if os(iOS)
            //            SettingsView()
            //#endif
            //        }
            .modifier(colorSchemeAutomatic())
        }
    }
}
