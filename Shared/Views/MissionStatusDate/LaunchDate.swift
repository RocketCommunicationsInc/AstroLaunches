//
//  LaunchCalendar.swift
//  Astro Launches
//
//  Created by rocketjeff on 10/7/21.
//

import SwiftUI

struct LaunchDate: View {
    var launch:Launch
    var labelStyle:Font.TextStyle = .body

    var body: some View {
        HStack(spacing: 10){
            Image(systemName: "calendar")
            if let time = launch.windowOpenDate {
                let dateString = ShortDateFormatter.sharedInstance.string(from: time)
                Text(dateString)
            }
            else {
                Text("Unknown")
            }
        }.font(Font.system(labelStyle))
        .foregroundColor(.launchesTextColor)
    }
}

struct LaunchCalendar_Previews: PreviewProvider {
    static var networkManager = NetworkManager()
    static var previews: some View {
        LaunchDate(launch:networkManager.upcomingLaunches[0])
            .previewLayout(.sizeThatFits)
        LaunchDate(launch:networkManager.upcomingLaunches[1])
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
        LaunchDate(launch:networkManager.upcomingLaunches[4])
            .previewLayout(.sizeThatFits)
    }
}
