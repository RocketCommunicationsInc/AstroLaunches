//
//  ContentView.swift
//  Astro Launches TV
//
//  Created by rocketjeff on 3/16/22.
//

import SwiftUI

// storage key constants
let appStorageViewModeKey = "ViewMode" // 0 for Conference Room, 1 for Ops Floor

enum ViewMode:Int{
    case conferenceRoom
    case bigScreen
}
struct ContentView: View {
    @StateObject var networkManager = NetworkManager()
    @State private var selection: Int = 1
    @AppStorage(appStorageViewModeKey) var viewMode:ViewMode = .conferenceRoom // default to Conference Room
    
    var body: some View {
        // show ConferenceRoomView or OpsFloorView
        ZStack{
            if (viewMode == .conferenceRoom)
            {
                ConferenceRoomView(networkManager: networkManager)
            }
            else
            {
                OpsFloorView(networkManager: networkManager)
            }
            
        } .contextMenu {
            Button("Conference Room View") { viewMode = .conferenceRoom }
            Button("Big Screen View")  { viewMode = .bigScreen }
        }
    }
}

