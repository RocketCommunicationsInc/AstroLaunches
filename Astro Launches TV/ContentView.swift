//
//  ContentView.swift
//  Astro Launches TV
//
//  Created by rocketjeff on 3/16/22.
//

import SwiftUI


struct ContentView: View {
    @StateObject var networkManager = NetworkManager()
    @State var conferenceRoomDisplay = false
    @State private var selection: Int = 1

    var body: some View {
        // show ConferenceRoomView or OpsFloorView
        ZStack{
            if (conferenceRoomDisplay)
            {
                ConferenceRoomView(networkManager: networkManager)
            }
            else
            {
                OpsFloorView(networkManager: networkManager)
            }
            
        } .contextMenu {
            Button("Conference Room View") { conferenceRoomDisplay = true }
            Button("Operations Floor View")  { conferenceRoomDisplay = false }
        }
    }
}

