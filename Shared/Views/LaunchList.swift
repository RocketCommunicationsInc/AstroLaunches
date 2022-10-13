//
//  LaunchList.swift
//  Shared
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI
import AstroSwiftFoundation

enum TimePeriod:Int {
    case upcoming
    case recent
    
    func name()->String{
        return self == .upcoming ? "Upcoming" : "Recent"
    }
}

struct LaunchList: View {
    @ObservedObject var networkManager: NetworkManager
    @AppStorage(colorSchemeAutomaticName) var colorSchemeAutomatic:ColorSchemeAutomatic = .automatic
    @AppStorage("TimePeriod") private var timeSpan:TimePeriod = .upcoming
    
    var body: some View{
        NavigationSplitView {
            // Stack the Upcoming and Previous lists, showing only one at at time based on timeSpan
            ZStack{
                if (timeSpan == .upcoming){
                    LaunchStack(networkManager: networkManager, timePeriod: .upcoming)
                        .navigationTitle("Upcoming")
                }
                else {
                    LaunchStack(networkManager: networkManager, timePeriod: .recent)
                        .navigationTitle("Recent")
                }
            }.toolbar{
#if os(iOS)
                ToolbarItem() {
                    Menu {
                        Picker(selection: $timeSpan, label:Text("Unused")) {
                            Text("Upcoming").tag(TimePeriod.upcoming)
                            Text("Recent").tag(TimePeriod.recent)
                        }
                    }
                    label: {
                        Image(systemName:"clock")
                    }
                }
#endif
#if os(macOS)
                ToolbarItem(placement: .automatic)
                {
                    Picker("", selection: self.$timeSpan) {
                        Text("Upcoming").tag(TimePeriod.upcoming)
                        Text("Recent").tag(TimePeriod.recent)
                    }.pickerStyle(.menu).frame(minWidth:110)
                }
#endif
            }
        }
    detail: {
        // preload the detail view before any selection is made, otherwise teh
        let launches = timeSpan == .upcoming ? networkManager.upcomingLaunches : networkManager.pastLaunches
        if let launch = launches.first{
            LaunchDetail(launch: launch)
        }
    }
    .alert(String(networkManager.alertTitle), isPresented: $networkManager.isShowingNetworkAlert){
        Button("Continue", role: .cancel) {}
    } message: {
        Text(networkManager.alertMessage)
    }
    .accentColor(Color("AccentColor")) // necessary because our forced light/dark modes, and UIAppearance usage, breaks automatic loading of AccentColor
    .preferredColorScheme(colorSchemeAutomatic == .light ? .light : colorSchemeAutomatic == .dark ? .dark : nil)
    }
    
    struct LaunchStack: View {
        @ObservedObject var networkManager: NetworkManager
        var timePeriod:TimePeriod
        //  @State var previousLaunchesLoaded = false
        @AppStorage(colorSchemeAutomaticName) var colorSchemeAutomatic:ColorSchemeAutomatic = .automatic // LaunchesView does not use this, but this must be present for ColorSchemeAutomaticToolbarContent to receive updates to colorSchemeAutomatic??
        
        var body: some View {
            ZStack{
                ScrollView {
                    LazyVStack() {
                        ForEach(timePeriod == .upcoming ? networkManager.upcomingLaunches : networkManager.pastLaunches, id: \.id) { launch in
                            NavigationLink {
                                LaunchDetail(launch: launch)
                            } label: {
                                LaunchRow(launch:launch)
                                    .padding(.top,3)
                                    .padding(.bottom,3)
                                    .padding(.leading,6)
                                    .padding(.trailing,6)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .listRowBackground(Color.astroUISecondaryBackground)
                        }
                    }
                    .toolbar {
                        ColorSchemeAutomaticToolbarContent() // show the theme switching menu
                    }
                }.background(Color.astroUIBackground)
                
                // if no data is available show a ProgressView
                let zeroData = timePeriod == .upcoming ? networkManager.upcomingLaunches.count == 0 : networkManager.pastLaunches.count == 0
                ProgressView().opacity(zeroData ? 1 : 0)
            }
#if os(macOS)
    .navigationSplitViewColumnWidth(min: 225, ideal: 275, max: 325) // not working
#endif

        }
    }
}
