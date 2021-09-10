//
//  LaunchRow.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/18/21.
//

import SwiftUI
import WidgetKit
struct LaunchRow: View {
    
    var launch:Launch
    
    var body: some View {
        VStack {
            // Launch Image and Countdown clock
            ZStack(alignment:.bottomTrailing){
                Image("launch").resizable().frame(minWidth: 10, idealWidth: 100, maxWidth: .infinity, minHeight: 10, idealHeight: 100, maxHeight: 100, alignment: .center)
                    .cornerRadius(5)
                CountdownPip(launch: launch)
            }
            HStack {
                Text(launch.name).font(.title2).bold()
                Spacer()
                Image(systemName: "bell").foregroundColor(.secondary)
                    .font(Font.system(.body))
            }.padding(.vertical, 4)
            ZStack{
                ClockPip(launch: launch) // a trick to center it in the HStack below: add in a zStack where it is naturally centered
                HStack (){
                    CalendarPip(launch: launch)
                    Spacer()
                    WeatherPip(launch: launch)
                }
                
            }.padding(.vertical, 4)
        }
    }
    
}

struct CountdownPip: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var launch:Launch

    var body: some View {
        HStack {
            if let windowOpenDate = launch.windowOpenDate
            {
                Text("T-")
                    .foregroundColor(.white)
                
                Text(windowOpenDate, style: .timer)
                    .foregroundColor(.white)
                    .font(.system(.body, design: .monospaced))
                //                    Text("H: M: S")
                //                        .foregroundColor(.white)
                //                        .font(.system(.body, design: .monospaced))
            }
        }
    }
}

struct CalendarPip: View {
    var launch:Launch

    var body: some View {
        HStack{
            Image(systemName: "calendar")
                .font(.body).foregroundColor(.secondary)
            Text(launch.date).font(.body).foregroundColor(.secondary)
        }//.background(Color(.red))
    }
}


struct ClockPip: View {
    var launch:Launch

    var body: some View {
        HStack{
            if let time = launch.windowOpenDate
            {
                Image(systemName: "clock").foregroundColor(.secondary)
                let dateString = TwentyFourHourTimeFormatter.sharedInstance.string(from: time)
                Text(dateString).font(.body).foregroundColor(.secondary)
            }
            else
            {
               // Text(" ").font(.body).foregroundColor(.secondary)
            }
        }
    }
}


struct WeatherPip: View {
    var launch:Launch
 
    var body: some View {
        HStack{
            if let weather = launch.weather
            {
                switch weather {
                case .unknown:
                    Text(" ").font(.body).foregroundColor(.secondary)
                case .sun:
                    Image(systemName: "sun.max").foregroundColor(.secondary)
                case .clouds:
                    Image(systemName: "cloud").foregroundColor(.secondary)
                case .rain:
                    Image(systemName: "cloud.rain").foregroundColor(.secondary)
                //            default:
                //                Text(" ").font(.body).foregroundColor(.secondary)
                }
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
        }//.background(Color(.green))
    }
}

struct LaunchRow_Previews: PreviewProvider {
    static var networkManager = NetworkManager()
    static var previews: some View {
        LaunchRow(launch:networkManager.launches[0])
            .previewLayout(.sizeThatFits)
        LaunchRow(launch:networkManager.launches[1])
            .previewLayout(.sizeThatFits)
        LaunchRow(launch:networkManager.launches[4])
            .previewLayout(.sizeThatFits)
    }
}
