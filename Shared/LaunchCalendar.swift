//
//  LaunchCalendar.swift
//  Astro Launches
//
//  Created by rocketjeff on 10/7/21.
//

import SwiftUI

struct LaunchCalendar: View {
    var launch:Launch

    var body: some View {
        HStack{
            Image(systemName: "calendar")
            if let time = launch.windowOpenDate
            {
                let dateString = ShortDateFormatter.sharedInstance.string(from: time)
                Text(dateString)
            }
            else
            {
                Text("Unknown")
            }
        }.font(.body)
            .foregroundColor(.launchesTextColor)
    }
}

struct LaunchCalendar_Previews: PreviewProvider {
    static var networkManager = NetworkManager()
    static var previews: some View {
        LaunchCalendar(launch:networkManager.launches[0])
            .previewLayout(.sizeThatFits)
        LaunchCalendar(launch:networkManager.launches[1])
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
        LaunchCalendar(launch:networkManager.launches[4])
            .previewLayout(.sizeThatFits)
    }
}
