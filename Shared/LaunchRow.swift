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
                if let windowOpenDate = launch.windowOpenDate
                {
                    let dateText = CountdownDateFormatter.sharedInstance.string(from: windowOpenDate)
                    Text(dateText).foregroundColor(.white).bold()
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
        Text(launch.date).font(.body).foregroundColor(.secondary)
    }
}


struct ClockPip: View {
    var launch:Launch

    var body: some View {
        Image(systemName: "clock").foregroundColor(.secondary)
        if let time = launch.windowOpenDate
        {
            let dateFormatter = DateFormatter()
            Text(dateFormatter.string(from: time)).font(.body).foregroundColor(.secondary)
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
        switch launch.weather {
        case .unknown:
            Text("-").font(.body).foregroundColor(.secondary)
        case .sun:
            Image(systemName: "sun.max").foregroundColor(.secondary)
        case .clouds:
            Image(systemName: "cloud").foregroundColor(.secondary)
        case .rain:
            Image(systemName: "cloud.rain").foregroundColor(.secondary)
        default:
            Text("-").font(.body).foregroundColor(.secondary)
        }

        if let temp = launch.temperature
        {
            let tempInt = Int(temp)
            Text(String(tempInt)+"°").font(.body).foregroundColor(.secondary)
        }
//        else
//        {
//            Text("-").font(.body).foregroundColor(.secondary)
//        }
    }
}

struct LaunchRow_Previews: PreviewProvider {
//    static let launchPreview = Launch(name: "Starlink-23",date_str: "Q1 2021",t0: "33", weather_temp: 44.44, weather_icon: "rain", win_open: "2021-03-22T22:20Z")
    static var previews: some View {
        Text("hello")

      //  LaunchRow(launch:launchPreview)
    }
}
