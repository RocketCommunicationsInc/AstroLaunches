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
    
    // the main view on iPhone, or sidebar on iPad
    var body: some View{
        TabView {
            LaunchesView(networkManager: networkManager, upcoming: true)
            LaunchesView(networkManager: networkManager, upcoming: false)
        }
        // watch for an alert posted by the networkManager
        .alert(String(networkManager.alertTitle), isPresented: $networkManager.isShowingNetworkAlert){
            Button("Continue", role: .cancel) {}
        } message: {
            Text(networkManager.alertMessage)
        }
        .accentColor(Color("AccentColor")) // necessary because our forced light/dark modes, and UIAppearance usage, breaks automatic loading of AccentColor
    }

    struct LaunchesView: View {
        @ObservedObject var networkManager: NetworkManager
        var upcoming:Bool
    
        var body: some View {
            NavigationView{
                ZStack{
                    ScrollView {
                        LazyVStack() {
                            ForEach(upcoming ? networkManager.upcomingLaunches : networkManager.pastLaunches, id: \.id) { launch in
                                NavigationLink(
                                    destination: LaunchDetail(launch: launch),
                                    label: {
                                        LaunchRow(launch:launch)
                                            .padding(.top,3)
                                            .padding(.bottom,3)
                                            .padding(.leading,6)
                                            .padding(.trailing,6)
                                    }).listRowBackground(Color.astroUISecondaryBackground)
                            }
                        }
                        .navigationTitle(upcoming ? "Upcoming" : "Previous")
                        .toolbar {
                            ColorSchemeAutomaticToolbarContent() // show the theme switching menu
                        }
                    }.background(Color.astroUIBackground)
                    // if no data is available show a ProgressView
                    let zeroData = upcoming ? networkManager.upcomingLaunches.count == 0 : networkManager.pastLaunches.count == 0
                    ProgressView().opacity(zeroData ? 1 : 0)
                }
            }
            .tabItem { Label(upcoming ? "Upcoming" : "Previous", systemImage:upcoming ? "clock" : "arrow.counterclockwise.circle" )}
            .modifier(colorSchemeAutomatic())
        }
    }
}

