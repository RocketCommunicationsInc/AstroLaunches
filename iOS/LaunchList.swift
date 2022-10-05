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
    @AppStorage(colorSchemeAutomaticName) var colorSchemeAutomatic:ColorSchemeAutomatic = .automatic
    
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
        .preferredColorScheme(colorSchemeAutomatic == .light ? .light : colorSchemeAutomatic == .dark ? .dark : nil)
    }
    
    struct LaunchesView: View {
        @ObservedObject var networkManager: NetworkManager
        var upcoming:Bool
        @State var previousLaunchesLoaded = false
        @AppStorage(colorSchemeAutomaticName) var colorSchemeAutomatic:ColorSchemeAutomatic = .automatic // LaunchesView does not use this, but this must be present for ColorSchemeAutomaticToolbarContent to receive updates to colorSchemeAutomatic??
        
        var body: some View {
            NavigationSplitView{
                ZStack{
                    ScrollView {
                        LazyVStack() {
                            ForEach(upcoming ? networkManager.upcomingLaunches : networkManager.pastLaunches, id: \.id) { launch in
                                NavigationLink {
                                    LaunchDetail(launch: launch)
                                } label: {
                                    LaunchRow(launch:launch)
                                        .padding(.top,3)
                                        .padding(.bottom,3)
                                        .padding(.leading,6)
                                        .padding(.trailing,6)
                                }.listRowBackground(Color.astroUISecondaryBackground)
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
        detail: {
            // preload the detail view before any selection is made, otherwise teh
            let launches = upcoming ? networkManager.upcomingLaunches : networkManager.pastLaunches
            if let launch = launches.first{
                LaunchDetail(launch: launch)
            }
        }
        .tabItem {
            Label(upcoming ? "Upcoming" : "Previous", systemImage:upcoming ? "clock" : "arrow.counterclockwise.circle" )
            
        }
        .onAppear(){
            // wait until the previous tab is shown the first time to load the previous launches, making startup faster and reducing server usage if the user never visits previous
            if !upcoming && !previousLaunchesLoaded {
                previousLaunchesLoaded = true
                networkManager.loadPreviousLaunches()
            }
            
            }
        }
    }
}

