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
        VStack(spacing:0) {
            // Launch Image and Countdown clock
            ImageAndCountdown(launch: launch, height: 200.0, showStatus: true)
            // Mission Name, Calendar, Clock
            MissionCalendarClock(launch: launch, showRocket: true)
                .padding()
           
        }.background(Color.launchesCardColor).cornerRadius(6)
    }
    
}

struct CountdownPip: View { 
  //  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

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
            }
        }
    }
}

struct CalendarPip: View {
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


struct ClockPip: View {
    var launch:Launch

    var body: some View {
        HStack{
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
        }.font(.body)
            .foregroundColor(.launchesTextColor)
    }
}


struct ImageAndCountdown: View {
    
    var launch:Launch
    var height:CGFloat
    var showStatus:Bool
    var body: some View {
        
        ZStack(alignment:.bottom){
            if let image = launch.image
            {
                ZStack(alignment:.topTrailing) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: 10, idealHeight: height, maxHeight: height, alignment: .top)
                    .clipped()
                    if let status = launch.status, status == "Go for Launch", showStatus == true
                    {
                        StatusTag(text: status,status: launch.astroStatus).padding()
                    }
                }
            }
            else
            {
                Image("launch")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: 10, idealHeight: height, maxHeight: height, alignment: .top)
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
    }
}

struct MissionCalendarClock: View {
    
    var launch:Launch
    var showRocket:Bool
    var body: some View {
        
        VStack {
            HStack
            {
                Text(launch.missionName).font(.title2).bold().foregroundColor(Color.launchesTextColor)
                if (showRocket)
                {
                    Tag(text: launch.rocketName)
                }
                Spacer()
            }.padding(.bottom, 4)
            HStack{
                CalendarPip(launch: launch).padding(.trailing, 6)
                ClockPip(launch: launch)
                Spacer()
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
