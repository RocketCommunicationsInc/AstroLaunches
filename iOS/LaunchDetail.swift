//
//  LaunchDetail.swift
//  Astro Launches
//
//  Created by rocketjeff on 9/7/21.
//

import SwiftUI

struct LaunchDetail: View {
    var launch:Launch
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading,spacing:0){
                // Launch Image and Countdown clock
                ImageBlock(launch: launch, height: 400, showStatus: false, wide:true)
                // Mission Name, Calendar, Clock
                MissionBlock(launch: launch, showRocket: false,showStatus: false).padding()
                // Longer mission description
                MissionDescription(launch: launch).padding()
                // Mission status, as a title and tag
                MissionStatus(launch: launch).padding()
                // Rocket and Location in stylized boxes, someday linking to detail views.
                RocketAndLocation(launch:launch).padding()
                // Map of the Launch Pad
                PadMap(coordinates:launch.locationCoordinate).frame(minHeight:100,idealHeight: 175).cornerRadius(6).padding()
            }
        }
        .background(Color.launchesSurfaceColor)
    }
}

struct MissionDescription: View {
    var launch:Launch
    var body: some View {
        VStack(alignment: .leading){
            Text("MISSION").font(.headline).foregroundColor(.launchesTextColor)
            Spacer()
            Text(launch.missionDescription).font(.body)
        }
    }
}



struct LaunchAgency: View {
    var launch:Launch
    var body: some View {
        VStack(alignment: .leading){
            Text("AGENCY").font(.headline).foregroundColor(.launchesTextColor)
            Spacer()
            Text(launch.serviceProviderName).font(.body)
        }.foregroundColor(.launchesTextColor)
    }
}



struct MissionStatus: View {
    var launch:Launch
    var body: some View {
        VStack(alignment: .leading) {
            Text("STATUS").font(.headline).foregroundColor(.launchesTextColor)

            if let status = launch.status
            {
                StatusTag(text: status,status: launch.astroStatus)//.foregroundColor(.launchesTextColor)
            }
        }
    }
}



struct RocketAndLocation: View {
    var launch:Launch
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing:16){
                VStack(alignment: .leading){
                    Text("ROCKET").font(.headline).foregroundColor(.launchesTextColor)
                    
                    ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 3.0, style: .continuous)
                            .fill(Color.launchesBoxColor).frame(minHeight:73)
                        Text(launch.rocketName).padding(.all,6).foregroundColor(.launchesTextColor)
                        
                    }
                }
                
                VStack(alignment: .leading){
                    Text("LOCATION").font(.headline).foregroundColor(.launchesTextColor)
                    
                    ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 3.0, style: .continuous)
                            .fill(Color.launchesBoxColor).frame(minHeight:73)
                        Text(launch.locationName).padding(.all,6).foregroundColor(.launchesTextColor)
                        
                    }
                }
            }
        }
    }
}

struct LaunchDetail_Previews: PreviewProvider {
    static var networkManager = NetworkManager()

    static var previews: some View {
        LaunchDetail(launch:networkManager.upcomingLaunches[0])
            .preferredColorScheme(.dark)
    }
}
