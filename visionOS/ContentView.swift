//
//  ContentView.swift
//  Astro Launches
//
//  Created by Jeff Hokit on 6/22/23.
//

import SwiftUI
import RealityKit
import RealityKitContent
import CachedAsyncImage
import AstroSwiftFoundation




// A root container view top host both view modes, and handle automatic view updating on a timer
struct ContentView: View {
    @ObservedObject var networkManager: NetworkManager
//    @State var launchIndex:Int = 0  // keep track of which launch is displayed. Shared by ConferenceRoomView OpsFloorView so their states are synchronized
    
    
    var body: some View {
        
        LaunchView(networkManager: networkManager/*, launchIndex: $launchIndex*/)
        // show any alerts created by the NetworkManager
        .alert(String(networkManager.alertTitle), isPresented: $networkManager.isShowingNetworkAlert){
            Button("Continue", role: .cancel) {}
        } message: {
            Text(networkManager.alertMessage)
            
        }

    }
}

