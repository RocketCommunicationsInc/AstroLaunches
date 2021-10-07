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
                ImageAndCountdown(launch: launch, height: 400, showStatus: false)
                // Mission Name, Calendar, Clock
                MissionCalendarClock(launch: launch, showRocket: false,showStatus: false).padding()
                MissionDescription(launch: launch).padding()
                MissionStatus(launch: launch).padding()

                HStack{
                    RocketBox(launch:launch)
                }.padding()
            }
        }
        .background(Color.launchesSurfaceColor)
    }
}

struct MissionDescription: View {
    var launch:Launch
    var body: some View {
        VStack(alignment: .leading){
            Text("MISSION").font(.headline)
            Spacer()
            Text(launch.missionDescription).font(.body)

        }.foregroundColor(.launchesTextColor)
    }
}



struct LaunchAgency: View {
    var launch:Launch
    var body: some View {
        VStack(alignment: .leading){
            Text("AGENCY").font(.headline)
            Spacer()
            Text(launch.serviceProviderName).font(.body)

        }.foregroundColor(.launchesTextColor)
    }
}



struct MissionStatus: View {
    var launch:Launch
    var body: some View {
        VStack(alignment: .leading) {
            Text("STATUS").font(.headline)
            if let status = launch.status
            {
                StatusTag(text: status,status: launch.astroStatus)
            }
        }.foregroundColor(.launchesTextColor)
    }
}



struct RocketBox: View {
    var launch:Launch
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing:16){
                VStack(alignment: .leading){
                    Text("ROCKET").font(.headline)
                    
                    ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 3.0, style: .continuous)
                            .fill(Color.launchesBoxColor).frame(minHeight:73)
                        Text(launch.rocketName).padding(.all,6)
                        
                    }
                }
                VStack(alignment: .leading){
                    Text("LOCATION").font(.headline)
                    
                    ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 3.0, style: .continuous)
                            .fill(Color.launchesBoxColor).frame(minHeight:73)
                        Text(launch.locationName).padding(.all,6)
                        
                    }
                }
            }
            
        }.foregroundColor(.launchesTextColor)
    }
}

struct LaunchDetail_Previews: PreviewProvider {
    static var networkManager = NetworkManager()

    static var previews: some View {
        LaunchDetail(launch:networkManager.launches[0])
            .preferredColorScheme(.dark)
    }
}
