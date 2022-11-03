//
//  ContentView.swift
//  Astro Launches TV
//
//  Created by rocketjeff on 3/16/22.
//

import SwiftUI

// create a timer to advance the automatic display
var displayTimer =  Timer.publish(every: 15, on: .main, in: .common).autoconnect()


// two view advance modes possible
enum AdvanceMode:Int{
    case automatic // automatically cycle through the launches
    case manual // hold on a single launch, advancing only when the user taps on the remote
}


// remember if the view is in auto or manual advance
let appStorageAdvanceModeKey = "AdvanceMode"


// A root container view top host both view modes, and handle automatic view updating on a timer
struct ContentView: View {
    @State var hudIsShowing = false
    @StateObject var networkManager = NetworkManager()
    @State var launchIndex:Int = 0  // keep track of which launch is displayed. Shared by ConferenceRoomView OpsFloorView so their states are synchronized
    let hudDelay:UInt64 = 3_000_000_000 // 3 billion nanoseconds == 3 seconds
    
    @AppStorage(appStorageAdvanceModeKey) var advanceMode:AdvanceMode = .automatic // default to automatic
    
    var body: some View {
        ZStack{ // ZStack to show the PlayPauseHUD above the content
            // HStack for all of the content
            
            LaunchView(networkManager: networkManager, launchIndex: $launchIndex)
            if (hudIsShowing){
                PlayPauseHUD()
            }
        }
        .focusable(true) // attract the automatic focus when swiftui loads this view, to receive contextMenu long press and other remote control functions
        
        
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
        .onReceive(displayTimer) { _ in
            if (advanceMode == .automatic)
            {
                // When receiving the timer, advance to the next launchIndex, wrapping around.
                launchIndex = (launchIndex + 1)  % networkManager.upcomingLaunches.count
            }
        }
        .onPlayPauseCommand(perform: {
            if (advanceMode == .automatic) {
                // set it to manual
                advanceMode = .manual
                
                // stop the timer
                 displayTimer.upstream.connect().cancel()
                
                // show the HUD
                withAnimation {
                    hudIsShowing = true
                    // after three seconds hide the hud, animated removal not working on tvOS 16
                    Task{
                        try? await Task.sleep(nanoseconds: hudDelay)
                        hudIsShowing = false
                    }
                }
            }
            else {
                // set it to automatic
                advanceMode = .automatic
                
                // restart the timer
                  displayTimer = Timer.publish(every: 15, on: .main, in: .common).autoconnect()
                
                // show the HUD
                withAnimation {
                    hudIsShowing.toggle()
                    // after three seconds hide the hud, animated removal not working on tvOS 16
                    Task{
                        try? await Task.sleep(nanoseconds: hudDelay)
                        hudIsShowing.toggle()
                    }
                }
            }
        })
        
    }
}

