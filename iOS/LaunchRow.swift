//
//  LaunchRow.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/18/21.
//

import SwiftUI
import WidgetKit
import SDWebImageSwiftUI

struct LaunchRow: View {
    
    var launch:Launch
    
    var body: some View {
        VStack(spacing:0) {
            // Launch Image and Countdown clock
            ImageAndCountdown(launch: launch, height: 200.0, showStatus: true)
            // Mission Name, Calendar, Clock
            MissionCalendarClock(launch: launch, showRocket: true, showStatus: true)
                .padding()
           
        }.background(Color.launchesSurfaceColor).cornerRadius(6)
    }
    
}







struct ImageAndCountdown: View {
    
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
                LaunchCountdown(launch: launch)
                    .padding(.trailing, 8)
                    .padding(.top, 2)
                    .padding(.bottom, 2)
            }
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
        }
    }
}

struct MissionCalendarClock: View {
    
    var launch:Launch
    var showRocket:Bool
    var showStatus:Bool
    
    var body: some View {
        
        VStack {
            HStack
            {
                Text(launch.missionName).font(.title2).bold().foregroundColor(Color.launchesTextColor)
                if (showRocket)
                {
                    Tag(text: launch.rocketName)
                }
                if let status = launch.status, status == "Go for Launch", showStatus == true
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
        LaunchRow(launch:networkManager.launches[0])
            .previewLayout(.sizeThatFits)
        LaunchRow(launch:networkManager.launches[1])
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
        LaunchRow(launch:networkManager.launches[4])
            .previewLayout(.sizeThatFits)
    }
}
