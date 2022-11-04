//
//  ConferenceRoomView.swift
//  Astro Launches TV
//
//  Created by rocketjeff on 10/4/21.
//

import SwiftUI
import AstroSwiftFoundation
import CachedAsyncImage

// Display Launch info with conventional tvOS sizing
struct LaunchView: View {
    
    @ObservedObject var networkManager: NetworkManager
    @Binding var launchIndex:Int
    
    var body: some View {
        
        if networkManager.upcomingLaunches.count > 0
        {
            let launch = networkManager.upcomingLaunches[launchIndex]
            HStack(spacing:0) {
                // ZStack for the large left side image and overlaid contents
                ZStack(alignment:.leading) {
                    
                    CachedAsyncImage(url:launch.imageURL, content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 1280, height: 1080, alignment: .topLeading)
                            .clipped()
                        // .blur(radius:4)
                    }, placeholder: {
                        ProgressView()
                    }).frame(width: 1280, height: 1080)
                    
                    VStack() {
                        Spacer()
                        Countdown(launch:launch, digitStyle: .title, labelStyle: .caption)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(6)
                        
                    }.padding(60)
                }
                // Right side bar
                Sidebar(launch: launch)
            }
            .transition(.opacity.animation(.easeInOut(duration:2.0))) // fade when launch updates
            .id("Main" + "\(launchIndex)") // create a changing ID so transition() will update all subviews
        }
    }
}


struct Sidebar: View {
    var launch:Launch

    var body: some View {
        
        VStack(alignment: .leading) {
            Group {
                Text(launch.missionName)
                    .font(.system(size: 34, weight: .semibold))
                Spacer()
                Text("ROCKET").font(.system(size: 24))
                    .foregroundColor(.launchesTextColor)
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
                    .focusable(false) // doesn't always work, still get focus if it's the only thing onscreen
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
                    Tag(text: status,status: launch.astroStatus)
                }
            }
            Spacer()
        }
        .padding(.all,40)
        .frame(width: 640, height: 1080, alignment: .leading)
        .background(Color.astroUIBackground) // *** Astro customization
    }
}


