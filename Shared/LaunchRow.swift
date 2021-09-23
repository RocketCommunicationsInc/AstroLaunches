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
        VStack() {
            // Launch Image and Countdown clock
            ZStack(alignment:.bottom){
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
                HStack() {
                    Image("AstroLogoTiny")
                        .frame(minWidth: 45, idealWidth: 45, maxWidth: 45, minHeight: 19, idealHeight: 19, maxHeight: 19, alignment: .topLeading)
                        .padding(.leading, 8)
                        .padding(.top, 4)
                        .padding(.bottom, 4)

                    Spacer()
                    CountdownPip(launch: launch)
                        .padding(.trailing, 8)
                        .padding(.top, 4)
                        .padding(.bottom, 4)
                }
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)

            }
            VStack {
                HStack
                {
                    Text(launch.missionName).font(.title2).bold().foregroundColor(Color.launchesTextColor)
                    Tag(text: launch.rocketName)
                    Spacer()
                }.padding(.bottom, 4)
                HStack{
                    CalendarPip(launch: launch).padding(.trailing, 6)
                    ClockPip(launch: launch)
                    Spacer()
                }
            }.padding()
           
        }.background(Color.launchesCardColor).cornerRadius(6)
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
                    .font(.body).foregroundColor(.launchesTextColor)
                let dateString = ShortDateFormatter.sharedInstance.string(from: time)
                Text(dateString).font(.body).foregroundColor(.launchesTextColor)
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
                Image(systemName: "clock").foregroundColor(.launchesTextColor)
                let dateString = TwentyFourHourTimeFormatter.sharedInstance.string(from: time)
                Text(dateString).font(.body).foregroundColor(.launchesTextColor)
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
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
        LaunchRow(launch:networkManager.launches[4])
            .previewLayout(.sizeThatFits)
    }
}
