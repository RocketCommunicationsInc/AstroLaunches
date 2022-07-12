//
//  LaunchRow.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/18/21.
//

import SwiftUI
import WidgetKit
import AstroSwiftFoundation

struct LaunchRow: View {
    
    var launch:Launch
    
    var body: some View {
        VStack(spacing:0) {
            // Launch Image and Countdown clock
            LaunchImageBlock(launch: launch, height: 200.0, showStatus: true)
            // Mission Name, Status Tags, Date, Time
            LaunchMissionBlock(launch: launch, showRocket: true, showStatus: true)
                .padding()
            
        }.background(Color.launchesSurfaceColor).cornerRadius(6)
    }
    
}




struct LaunchRow_Previews: PreviewProvider {
    static var networkManager = NetworkManager()
    static var previews: some View {
        LaunchRow(launch:networkManager.upcomingLaunches[0])
            .previewLayout(.sizeThatFits)
        LaunchRow(launch:networkManager.upcomingLaunches[1])
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
        LaunchRow(launch:networkManager.upcomingLaunches[4])
            .previewLayout(.sizeThatFits)
    }
}
