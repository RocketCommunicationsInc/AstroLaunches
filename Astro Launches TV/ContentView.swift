//
//  ContentView.swift
//  Astro Launches TV
//
//  Created by rocketjeff on 3/16/22.
//

import SwiftUI

// create a central timer shared to advance the automatic display
var displayTimer =  Timer.publish(every: 15, on: .main, in: .common).autoconnect()

// two view modes possible
enum ViewMode:Int{
    case conferenceRoom
    case bigScreen
}

// remember the last selected view mode
let appStorageViewModeKey = "ViewMode"


// A root container view top host both view modes, and handle automatic view updating on a timer
struct ContentView: View {
    @StateObject var networkManager = NetworkManager()
    @State var launchIndex:Int = 0  // keep track of which launch is displayed. Shared by ConferenceRoomView OpsFloorView so their states are synchronized
    
    @AppStorage(appStorageViewModeKey) var viewMode:ViewMode = .conferenceRoom // default to Conference Room
    
    var body: some View {
        // show ConferenceRoomView or OpsFloorView
        ZStack{
            if (viewMode == .conferenceRoom)
            {
                ConferenceRoomView(networkManager: networkManager, launchIndex: $launchIndex)
            }
            else
            {
                OpsFloorView(networkManager: networkManager, launchIndex: $launchIndex)
            }
        }
        .contextMenu { // activaged by long press on remote center button
            Button("Conference Room View") { viewMode = .conferenceRoom }
            Button("Big Screen View")  { viewMode = .bigScreen }
        }
        .onReceive(displayTimer) { _ in
            // When receiving the timer, advance to the next launchIndex, wrapping around.
            launchIndex = (launchIndex + 1)  % networkManager.upcomingLaunches.count
        }
    }
}

