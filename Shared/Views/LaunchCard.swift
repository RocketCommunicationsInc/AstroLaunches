//
//  LaunchCard.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/18/21.
//

import SwiftUI
import WidgetKit
import AstroSwiftFoundation

struct LaunchCard: View {
    
    var launch:Launch
    
    var body: some View {
        VStack(spacing:0) {
            // Launch Image and Countdown clock
            LaunchCardImage(launch: launch, height: 200.0)
            // Mission Name, Status Tags, Date, Time
            MissionStatusDate(launch: launch, showRocket: true, showStatus: true, showMissionName: true)
                .padding()
            
        }.background(Color.astroUISecondaryBackground).cornerRadius(6)
    }
    
}




struct LaunchRow_Previews: PreviewProvider {
    static var networkManager = NetworkManager(timePeriods: [.upcoming])
    static var previews: some View {
        LaunchCard(launch:networkManager.upcomingLaunches[0])
            .previewLayout(.sizeThatFits)
        LaunchCard(launch:networkManager.upcomingLaunches[1])
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
        LaunchCard(launch:networkManager.upcomingLaunches[4])
            .previewLayout(.sizeThatFits)
    }
}
