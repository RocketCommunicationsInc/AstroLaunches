//
//  LaunchClock.swift
//  Astro Launches
//
//  Created by rocketjeff on 10/7/21.
//

import SwiftUI

struct LaunchClock: View {
    var launch:Launch
    var labelStyle:Font.TextStyle = .body

    var body: some View {
        HStack(spacing: 10){
            Image(systemName: "clock")
            if let time = launch.windowOpenDate
            {
                let dateString = TwentyFourHourTimeFormatter.sharedInstance.string(from: time)
                Text(dateString)
            }
            else
            {
                Text("Unknown")
            }
        }.font(Font.system(labelStyle))
        .foregroundColor(.launchesTextColor)
    }
}



struct LaunchClock_Previews: PreviewProvider {
    static var networkManager = NetworkManager()
    static var previews: some View {
        LaunchClock(launch:networkManager.upcomingLaunches[0])
            .previewLayout(.sizeThatFits)
        LaunchClock(launch:networkManager.upcomingLaunches[1])
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
