//
//  LaunchList.swift
//  Shared
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI
import AstroSwiftFoundation
import AstroSwiftUtilities

// The Main View of the app.
// Divide the screen with a NavigationSplitView, list of launches on the left, detail view on the right
struct ContentView: View {
    @ObservedObject var networkManager: NetworkManager
    @AppStorage(colorSchemeAutomaticName) var colorSchemeAutomatic:ColorSchemeAutomatic = .automatic
    @AppStorage("TimePeriod") private var timeSpan:TimePeriod = .upcoming
    
    var body: some View{
        NavigationSplitView {
            // Stack the Upcoming and Previous lists, showing only one at at time based on timeSpan
            ZStack{
                if (timeSpan == .upcoming){
                    LaunchStack(networkManager: networkManager, timePeriod: .upcoming)
                        .navigationTitle(timeSpan.name())
                }
                else {
                    LaunchStack(networkManager: networkManager, timePeriod: .recent)
                        .navigationTitle(timeSpan.name())
                }
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 225, ideal: 275, max: 325)
#endif
            .toolbar{
#if os(iOS) // on iOS show a toolbar icon with attached menu to switch time period
                ToolbarItem() {
                    Menu {
                        Picker(selection: $timeSpan, label:Text("Unused")) {
                            Text(TimePeriod.upcoming.name()).tag(TimePeriod.upcoming)
                            Text(TimePeriod.recent.name()).tag(TimePeriod.recent)
                        }
                    }
                label: {
                    Image(systemName:"clock")
                }
                }
#endif
#if os(macOS) // on macOS show an inline toolbar menu to switch time period
                ToolbarItem(placement: .automatic)
                {
                    Picker("", selection: self.$timeSpan) {
                        Text(TimePeriod.upcoming.name()).tag(TimePeriod.upcoming)
                        Text(TimePeriod.recent.name()).tag(TimePeriod.recent)
                    }.pickerStyle(.menu).frame(minWidth:110)
                }
#endif
            }
        }
    detail: {
        // preload the detail view before any selection is made
        let launches = timeSpan == .upcoming ? networkManager.upcomingLaunches : networkManager.recentLaunches
        if let launch = launches.first{
            LaunchDetail(launch: launch)
        }
    }
    // show any alerts created by the NetworkManager
    .alert(String(networkManager.alertTitle), isPresented: $networkManager.isShowingNetworkAlert){
        Button("Continue", role: .cancel) {}
    } message: {
        Text(networkManager.alertMessage)
    }
        // *** Astro customization
    .accentColor(Color("AccentColor")) // necessary because our forced light/dark modes, and UIAppearance usage, breaks automatic loading of AccentColor
    .preferredColorScheme(colorSchemeAutomatic == .light ? .light : colorSchemeAutomatic == .dark ? .dark : nil)
    }
    
    struct LaunchStack: View {
        @ObservedObject var networkManager: NetworkManager
        var timePeriod:TimePeriod
//        @AppStorage(colorSchemeAutomaticName) var colorSchemeAutomatic:ColorSchemeAutomatic = .automatic // LaunchStack does not use this, but this must be present for ColorSchemeAutomaticToolbarContent to receive updates to colorSchemeAutomatic??
        
        var body: some View {
            ZStack{
                ScrollView {
                    LazyVStack() {
                        ForEach(timePeriod == .upcoming ? networkManager.upcomingLaunches : networkManager.recentLaunches, id: \.id) { launch in
                            NavigationLink {
                                LaunchDetail(launch: launch)
                            } label: {
                                LaunchCard(launch:launch)
                                    .padding(.top,3)
                                    .padding(.bottom,3)
                                    .padding(.leading,6)
                                    .padding(.trailing,6)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .listRowBackground(Color.astroUISecondaryBackground) // *** Astro customization
                        }
                    }
#if os(iOS)
                    .toolbar {
                        ColorSchemeAutomaticToolbarContent() // show the theme switching menu
                    }
#endif
                }.background(Color.astroUIBackground) // *** Astro customization
                    .refreshable {
                        networkManager.refreshLaunches()
                    }
                
                // if no data is available show a ProgressView
                let zeroData = timePeriod == .upcoming ? networkManager.upcomingLaunches.count == 0 : networkManager.recentLaunches.count == 0
                ProgressView().opacity(zeroData ? 1 : 0)
            }
            
        }
    }
}
