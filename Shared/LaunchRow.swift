//
//  LaunchRow.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/18/21.
//

import SwiftUI

struct LaunchRow: View {
    
    var launch:Launch
    
    var body: some View {
        VStack {
            ZStack(alignment:.bottomTrailing){
                Image("launch").resizable().frame(minWidth: 10, idealWidth: 100, maxWidth: .infinity, minHeight: 10, idealHeight: 100, maxHeight: 100, alignment: .center)
                    .cornerRadius(5)
                CountdownPip(launch: launch)
            }
            HStack {
                Text(launch.name).font(.title2).bold()
                Spacer()
                Image(systemName: "bell.fill").foregroundColor(.astroUITint)
                    .font(Font.system(.body))
            }.padding(.vertical, 4)
            HStack {
                CalendarPip(launch: launch)
                Spacer()
                ClockPip(launch: launch)
                Spacer()
                WeatherPip(launch: launch)

            }.padding(.vertical, 4)
        }
    }
    
}

struct CountdownPip: View {
    var launch:Launch

    var body: some View {
        HStack {
            VStack{
                if let win_open = launch.win_open
                {
                    let iso8601DateFormatter = ISO8601DateFormatter()
                    let date = iso8601DateFormatter.date(from: win_open)
//                    iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                    
                Text(win_open).foregroundColor(.white).bold()
                Text("D H M S").foregroundColor(.white)
                }
            }
        }
    }
}

struct CalendarPip: View {
    var launch:Launch

    var body: some View {
        Image(systemName: "calendar")
            .font(.body).foregroundColor(.secondary)
        Text(launch.date_str).font(.body).foregroundColor(.secondary)
    }
}


struct ClockPip: View {
    var launch:Launch

    var body: some View {
        Image(systemName: "clock").foregroundColor(.secondary)
        if let time = launch.t0
        {
            Text(time).font(.body).foregroundColor(.secondary)
        }
        else
        {
            Text("-").font(.body).foregroundColor(.secondary)
        }
    }
}


struct WeatherPip: View {
    var launch:Launch

    var body: some View {
        if let weatherIcon = launch.weather_icon
        {
            if weatherIcon.contains("cloud")
            {
                Image(systemName: "cloud").foregroundColor(.secondary)
            }
            else if weatherIcon.contains("rain")
            {
                Image(systemName: "cloud.rain").foregroundColor(.secondary)
            }
            else
            {
                Image(systemName: "sun.max").foregroundColor(.secondary)
            }
        }
        else
        {
        Image(systemName: "sun.max").foregroundColor(.secondary)
        }
        if let temp = launch.weather_temp
        {
            let tempInt = Int(temp)
            Text(String(tempInt)+"°").font(.body).foregroundColor(.secondary)
        }
        else
        {
            Text("-").font(.body).foregroundColor(.secondary)
        }
    }
}

struct LaunchRow_Previews: PreviewProvider {
    
    static let launchPreview = Launch(name: "Starlink-23",date_str: "Q1 2021",t0: "33", weather_temp: 44.44, weather_icon: "rain", win_open: "2021-03-22T22:20Z")
    static var previews: some View {
        LaunchRow(launch:launchPreview)
    }
}
