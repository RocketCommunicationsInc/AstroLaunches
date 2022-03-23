//
//  ConferenceRoomView.swift
//  Astro Launches TV
//
//  Created by rocketjeff on 10/4/21.
//

import SwiftUI
import AstroSwiftFoundation
import SDWebImageSwiftUI

struct ConferenceRoomView: View {
    
    @ObservedObject var networkManager: NetworkManager
    @Binding var launchIndex:Int
       
    var body: some View {

        if networkManager.launches.count > 0
        {
        let launch = networkManager.launches[launchIndex]
            // HStack for the whole screen
            HStack(spacing:0) {
                // ZStack for the large left side image and overlaid contents
                ZStack(alignment:.leading) {
                    WebImage(url: launch.imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 1280, height: 1080, alignment: .topLeading)
                        .clipped()
                        .blur(radius:4)
                    
                    VStack(alignment:.leading,spacing: 100) {
                        LogoNameCountdown(launch:launch)
                        HStack{
                            LaunchCalendar(launch:launch, labelStyle:.headline)
                            LaunchClock(launch:launch, labelStyle:.headline)
                        }
                    }.padding(.leading, 80)
                }
                // Right side bar
                Sidebar(launch: launch)
            }.transition(.opacity.animation(.easeInOut(duration:2.0))) // fade when launch updates
                .id("Main" + "\(launchIndex)") // force a unique ID to let transition work
            .onReceive(centralDisplayTimer) { _ in
                // When receiving the 15 second timer, advance to the next launchIndex, wrapping around.
                // Note that this will cause a runtime warning  "Modifying state during view update, this will cause undefined behavior."
                // I have not found any workaround for this, including putting the launchIndex on another thread.
                // This is a common pattern to update the view, seen throuhout the SwiftUI literature. Not sure why the warning happens
                // here, maybe because the update is so major, a whole screenful of content?
                launchIndex = (launchIndex + 1)  % networkManager.launches.count
            }
        }
    }
}


struct Sidebar: View {
    var launch:Launch

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Spacer()

                Text("ROCKET").font(.system(size: 24))
                    .foregroundColor(.launchesTextColor)
                    .focusable(true) // attract the automatic focus when swiftui loads this view, so the map doesn't get improperly focused
                Text(launch.rocketName).font(.system(size: 32))
                    .foregroundColor(Color(.label))
                Spacer()
                Divider()

            }

            Group {
                Spacer()
                
                Text("LOCATION").font(.system(size: 24))
                    .foregroundColor(.launchesTextColor)
                Text(launch.locationName).font(.system(size: 32))
                    .foregroundColor(Color(.label))
                PadMap(coordinates:launch.locationCoordinate).frame(minHeight:100,idealHeight: 175).cornerRadius(6)
                    .focusable(false) // doesn't work, still get focus if it's the only thing onscreen
                Spacer()
                Divider()
                
            }
            Group {
                Spacer()
                
                Text("MISSION").font(.system(size: 24))
                    .foregroundColor(.launchesTextColor)
                Text(launch.missionDescription).font(.system(size: 32))
                    .foregroundColor(Color(.label))
                Spacer()
                Divider()
            }
            Group {
                Spacer()
                
                Text("STATUS").font(.system(size: 24))
                    .foregroundColor(.launchesTextColor)
                if let status = launch.status
                {
                    StatusTag(text: status,status: launch.astroStatus)
                }
                
            }
            Spacer()
            
        }.padding(.all,40)
            .frame(width: 640, height: 1080, alignment: .leading)
            .background(Color.launchesSurfaceColor)
    }
}



struct LogoNameCountdown: View {
    var launch:Launch

    var body: some View {
        HStack(alignment: .bottom) {
            if let url = launch.agency?.logoURL
            {
                // if this malformed spaceX logo is referenced, use our internal copy instead
                if url == URL(string: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/logo/spacex_logo_20191121063502.png")
                {
                    Image(uiImage: UIImage(named:"spacex_logo_trimmed")!)
                    .resizable()
                    .padding(4)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300,alignment: .center)
                    .background(.ultraThinMaterial)
                    .cornerRadius(6)
                }
                else
                {
                    WebImage(url:url)
                    .resizable()
                    .padding()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300,alignment: .center)
                    .background(.ultraThinMaterial)
                    .cornerRadius(6)
                }
            }
            
            VStack(alignment: .leading)
            {
                let titleFontSize = UIFont.preferredFont(forTextStyle: .title1).pointSize
                
                Text(launch.missionName)
                    .font(.system(size: titleFontSize * 1.2, weight: .semibold))
                    .padding()
                LaunchCountdown(launch:launch, digitStyle: .title, labelStyle: .caption)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(6)
            }
            Spacer()
        }
    }
}



