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
                MissionCalendarClock(launch: launch, showRocket: false).padding()
                MissionDescription(launch: launch)
                Spacer()
                DetailTags(launch: launch).padding()
            }//.background(Color.astroUIBackground)
        }
        .background(Color.astroUIBackground)
    }
}

struct MissionDescription: View {
    var launch:Launch
    var body: some View {
        VStack(alignment: .leading){
            Text("Mission").font(.title3)
            Spacer()
            Text(launch.missionDescription).font(.body)

        }.foregroundColor(.launchesTextColor).padding()
    }
}


struct DetailTags: View {
    var launch:Launch
    var body: some View {
        VStack(alignment: .leading) {
            Text("Status").font(.title3)
            HStack{
                if let status = launch.status
                {
                    StatusTag(text: status,status: launch.astroStatus)
                }
            }
        }
    }
}


struct LaunchDetail_Previews: PreviewProvider {
    static var networkManager = NetworkManager()

    static var previews: some View {
        LaunchDetail(launch:networkManager.launches[0])
            .preferredColorScheme(.dark)
    }
}
