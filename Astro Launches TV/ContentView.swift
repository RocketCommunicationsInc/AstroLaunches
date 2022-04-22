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
    case conferenceRoom  // standard tvOS sizes
    case bigScreen  // scaled for a 70" screen at 15 feet, matching our companion Giant Screen article
}

// two view advance modes possible
enum AdvanceMode:Int{
    case automatic // automatically cycle through the launches
    case manual // hold on a single launch, advancing only when the user taps on the remote
}


// remember the last selected view mode
let appStorageViewModeKey = "ViewMode"
// remember if the view is in auto or manual advance
let appStorageAdvanceModeKey = "AdvanceMode"


// A root container view top host both view modes, and handle automatic view updating on a timer
struct ContentView: View {
    @StateObject var networkManager = NetworkManager()
    @State var launchIndex:Int = 0  // keep track of which launch is displayed. Shared by ConferenceRoomView OpsFloorView so their states are synchronized
    
    @AppStorage(appStorageViewModeKey) var viewMode:ViewMode = .conferenceRoom // default to Conference Room
    @AppStorage(appStorageAdvanceModeKey) var advanceMode:AdvanceMode = .automatic // default to automatic

    var body: some View {
        // show ConferenceRoomView or OpsFloorView (aka Standard or Giant Screen in the UI)
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
        .focusable(true) // attract the automatic focus when swiftui loads this view, to receive contextMenu long press and other remote control functions
        .onPlayPauseCommand(perform: {
            advanceMode = advanceMode == .automatic ? .manual : .automatic
        })
        .onMoveCommand(perform: {(direction) in // activated by a TAP (not a presss) on the left or right remote control pad
            switch direction {
            case .left:
                launchIndex = ((launchIndex - 1) + networkManager.upcomingLaunches.count)  % networkManager.upcomingLaunches.count
            case .right:
                launchIndex = (launchIndex + 1)  % networkManager.upcomingLaunches.count
            default:
                break
            }
        })
        .contextMenu { // activated by long press on remote center button
            Button("Standard") { viewMode = .conferenceRoom }
            Button("Giant Screen")  { viewMode = .bigScreen }
        }
        .onReceive(displayTimer) { _ in
            if (advanceMode == .automatic)
            {
                // When receiving the timer, advance to the next launchIndex, wrapping around.
                launchIndex = (launchIndex + 1)  % networkManager.upcomingLaunches.count
            }
        }
    }
}

