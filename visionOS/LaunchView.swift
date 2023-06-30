//
//  LaunchView.swift
//  Astro Launches visionOS
//
//  Created by rocketjeff on 10/4/21.
//

import SwiftUI
import AstroSwiftFoundation
import CachedAsyncImage

#Preview {
    LaunchView(networkManager: NetworkManager.init(timePeriods: [.upcoming]), launchIndex: 0)
}

struct LaunchView: View {
    
    @ObservedObject var networkManager: NetworkManager
    @State var launchIndex:Int = 0
    
    var body: some View {
        GeometryReader { proxy in
            
            if networkManager.upcomingLaunches.count > 0
            {
                let launch = networkManager.upcomingLaunches[launchIndex]
                HStack(spacing:0) {
                    // ZStack for the large left side image and overlaid contents
                    ZStack(alignment:.leading) {
                        
                        CachedAsyncImage(url:launch.imageURL, content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: proxy.size.width * 0.7)
                                .clipped()
                        }, placeholder: {
                            ProgressView()
                        })
                        
                        VStack() {
                            Spacer()
                            if let windowOpenDate = launch.windowOpenDate
                            {
                                IntervalTimer(targetDate: windowOpenDate,options: .all, digitTextStyle: .title, labelFontStyle: .caption)
                                    .padding()
                                    .background(.regularMaterial)
                                    .cornerRadius(6)
                            }
                        }
                    }
                    // Right side bar
                    Sidebar(launch: launch).frame(width: proxy.size.width * 0.3)
                }
                //  .transition(.opacity.animation(.easeInOut(duration:2.0))) // fade when launch updates
                // .id("Main" + "\(launchIndex)") // create a changing ID so transition() will update all subviews
            }
        }
        .ornament(attachmentAnchor: .scene(alignment: .bottom)) {
            HStack{
                Button(action: {
                    launchIndex = ((launchIndex - 1) + networkManager.upcomingLaunches.count)  % networkManager.upcomingLaunches.count
                }) {
                    Image(systemName:"arrow.left.circle").font(.title)
                }
                Button(action: {
                    launchIndex = (launchIndex + 1)  % networkManager.upcomingLaunches.count
                }) {
                    Image(systemName:"arrow.right.circle").font(.title)
                }
            }
        }
        .transition(.opacity.animation(.easeInOut(duration:1.0))) // fade when launch updates
        .id("Main" + "\(launchIndex)") // create a changing ID so transition() will update all subviews

    }
}


struct Sidebar: View {
    var launch:Launch

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(launch.missionName)
                .font(.title)
                Spacer()
                Text("ROCKET").font(.title3)
                Text(launch.rocketName).font(.body)
                    .padding()
                    .background(.regularMaterial, in: .rect(cornerRadius: 12))
                    .hoverEffect()
                Spacer()
                Divider()
            }

            Group {
                Spacer()
                Text("LOCATION").font(.title3)
                    .foregroundColor(.launchesTextColor)
                Text(launch.locationName).font(.body)
                    .foregroundColor(Color(.label))
                PadMap(coordinates:launch.locationCoordinate).frame(minHeight:100,idealHeight: 175,maxHeight: 200).cornerRadius(6)
                    .focusable(false) // doesn't always work, still get focus if it's the only thing onscreen
                Spacer()
                Divider()
            }
            
            Group {
                Spacer()
                Text("MISSION").font(.title3)
                    .foregroundColor(.launchesTextColor)
                Text(launch.missionDescription).font(.body)
                    .foregroundColor(Color(.label))
                Spacer()
                Divider()
            }
            
            Group {
                Spacer()
                Text("STATUS").font(.title3)
                    .foregroundColor(.launchesTextColor)
                if let status = launch.status
                {
                    Tag(text: status,status: launch.astroStatus)
                }
            }
            Spacer()
        }
        .padding(.all,20)
    }
}


