//
//  LaunchRow.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/18/21.
//

import SwiftUI
import WidgetKit
import SDWebImageSwiftUI
import AstroSwiftFoundation

struct LaunchRow: View {
    
    var launch:Launch
    
    var body: some View {
        VStack(spacing:0) {
            // Launch Image and Countdown clock
            ImageAndCountdown(launch: launch, height: 200.0, showStatus: true)
            // Mission Name, Status Tags, Calendar, Clock
            MissionCalendarClock(launch: launch, showRocket: true, showStatus: true)
                .padding()
            
        }.background(Color.launchesSurfaceColor).cornerRadius(6)
    }
    
}


struct ImageAndCountdown: View {
    
    @Environment(\.openURL) var openURL
    var launch:Launch
    var height:CGFloat
    var showStatus:Bool
    var wide = false
    var body: some View {
        
        ZStack(alignment:.bottom){
            if let imageURL = launch.imageURL
            {
                ZStack(alignment:.topTrailing) {
                    if (wide) // wide mode for display on ipad detail screen
                    {
                        WebImage(url:imageURL)
                            .resizable()
                            .indicator(.activity)
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: 10, maxHeight: height, alignment: .top)
                            .blur(radius:8)
                            .clipped()
                        
                        
                        WebImage(url:imageURL)
                            .resizable()
                            .indicator(.activity)
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: 10, maxHeight: height, alignment: .top)
                            .clipped()
                    }
                    else
                    {
                        WebImage(url:imageURL)
                            .resizable()
                            .indicator(.activity)
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: 10, maxHeight: height, alignment: .top)
                            .clipped()
                    }
                }
            }
            else // no image available, use our stock photo
            {
                Image("launch")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: 10, idealHeight: height, maxHeight: height, alignment: .top)
                    .clipped()
            }
            
            // video if available
            VStack{
                HStack{
                    Spacer()
                    if let videoURL = launch.videoURL
                    {
                        Button(action: {
                            openURL(videoURL)
                        }) {
                            if (launch.webcast){
                                HStack {
                                    Image(systemName: "video.fill")
                                    Text("Watch Live")
                                }
                            }
                            else {
                                HStack {
                                    Image(systemName: "video.fill")
                                    Text("Watch")
                                }
                            }
                        }.buttonStyle(.bordered).font(.caption).background(.regularMaterial)//.padding(.trailing,6)
                    }
                }.padding(6)
                Spacer()
                
                HStack() {
                    if let url = launch.agency?.logoURL
                    {
                        WebImage(url:url)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40,  alignment: .center)
                            .padding(.leading, 8)
                        
                    }
                    Spacer()
                    // only show countown for launches in the future
                    if let interval = launch.windowOpenDate?.timeIntervalSinceNow
                    {
                        if interval > 0
                        {
                            LaunchCountdown(launch: launch)
                                .padding(.trailing, 8)
                                .padding(.top, 2)
                                .padding(.bottom, 2)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
            }
        }
    }
}

struct MissionCalendarClock: View {
    
    var launch:Launch
    var showRocket:Bool
    var showStatus:Bool
    
    var body: some View {
        
        VStack {
            HStack{
                Text(launch.missionName).font(.title2).bold().foregroundColor(Color(uiColor:.label))
                Spacer()
            }
            HStack
            {
                if (showRocket)
                {
                    Tag(text: launch.rocketName)
                }
                //                if let status = launch.status, launch.astroStatus != AstroStatus.Standby, showStatus == true
                //                {
                //                    StatusTag(text: status,status: launch.astroStatus)
                //                }
                if let status = launch.status, showStatus == true
                {
                    StatusTag(text: status,status: launch.astroStatus)
                }
                
                Spacer()
            }.padding(.bottom, 4)
            
            HStack{
                LaunchCalendar(launch: launch).padding(.trailing, 6)
                LaunchClock(launch: launch)
                Spacer()
            }
        }
        
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
