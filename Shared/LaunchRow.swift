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
        VStack(spacing: -8) {
            // Launch Image and Countdown clock
            ZStack(alignment:.bottomTrailing){
                if let image = launch.image
                {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: 10, idealHeight: 200, maxHeight: 200, alignment: .topLeading)
                        .clipped()
                    
                }
                else
                {
                    Image("launch")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: 10, idealHeight: 200, maxHeight: 200, alignment: .topLeading)
                        .clipped()

                }
                CountdownPip(launch: launch)
                    //.clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .padding(.all, 8.00)
                    .background(.ultraThinMaterial)
            }
            HStack
            {
                Text(launch.name).font(.title2).bold()
                Spacer()
            }.padding()
            HStack{
                CalendarPip(launch: launch)
                Spacer()
                ClockPip(launch: launch)                
            }.padding()//.padding(.vertical, 2)
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
        }//.clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))

    }
}

struct CalendarPip: View {
    var launch:Launch

    var body: some View {
        HStack{
            if let time = launch.windowOpenDate
            {
                Image(systemName: "calendar")
                    .font(.body).foregroundColor(.secondary)
                let dateString = ShortDateFormatter.sharedInstance.string(from: time)
                Text(dateString).font(.body).foregroundColor(.secondary)
            }
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
