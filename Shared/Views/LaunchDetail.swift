//
//  LaunchDetail.swift
//  Astro Launches
//
//  Created by rocketjeff on 9/7/21.
//

import SwiftUI
import AstroSwiftFoundation

struct LaunchDetail: View {
    var launch:Launch
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading,spacing:0){
                // Launch Image and Countdown clock
                LaunchDetailImage(launch: launch, height: 400)
                // Mission Name, Calendar, Clock
                MissionStatusDate(launch: launch, showRocket: false,showStatus: false, showMissionName: false).padding()
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
        .background(Color.astroUIBackground) // *** Astro customization
        .navigationTitle(launch.missionName)
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
                Tag(text: status,status: launch.astroStatus)
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
                            .fill(Color.astroUISecondaryBackground).frame(minHeight:73) // *** Astro customization
                        Text(launch.rocketName).padding(.all,6).foregroundColor(.launchesTextColor)
                        
                    }
                }
                
                VStack(alignment: .leading){
                    Text("LOCATION").font(.headline).foregroundColor(.launchesTextColor)
                    
                    ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 3.0, style: .continuous)
                            .fill(Color.astroUISecondaryBackground).frame(minHeight:73) // *** Astro customization
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
