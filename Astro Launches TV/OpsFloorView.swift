//
//  OpsFloorView.swift
//  Astro Launches TV
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI
import AstroSwiftFoundation
import SDWebImageSwiftUI

// Display Launch info in a super-sized format suitable for larger screens and longer distance, a "Giant Screen UI"
struct OpsFloorView: View {
    
    @ObservedObject var networkManager: NetworkManager
    @Binding var launchIndex:Int
    
    var body: some View {
        if networkManager.upcomingLaunches.count > 0 // don't display until networkManager has data
        {
            let launch = networkManager.upcomingLaunches[launchIndex]
            // HStack for the whole screen
            HStack(spacing:0) {
                // Left side: image, mission name and coundtown clock
                ZStack(alignment:.leading) {
                    WebImage(url: launch.imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 1280, height: 1080, alignment: .topLeading)
                        .clipped()
                        .blur(radius:2)
                    
                    VStack(alignment: .leading)
                    {
                        Text(launch.missionName)
                            .font(.system(size: 90, weight: .semibold, design: .default))
                            .padding()
                            .background(.thickMaterial)
                            .cornerRadius(6)
                        
                        GiantLaunchCountdown(launch:launch)
                            .padding()
                            .background(.thickMaterial)
                            .cornerRadius(6)
                        
                    }.padding(.leading,40)
                }
                // Right rocket name, status and location
                VStack(alignment: .leading) {
                    Text("ROCKET")
                        .font(.system(size: 60))
                        .foregroundColor(.launchesTextColor)
                    Text(launch.rocketName)
                        .font(.system(size: 60, weight: .semibold))
                        .foregroundColor(Color(.label))
                    Spacer()
                    
                    Text("STATUS").font(.system(size: 60))
                        .foregroundColor(.launchesTextColor)
                    if let status = launch.status
                    {
                        TitleStatusTag(text: status,status: launch.astroStatus)
                    }
                    Spacer()
                    
                    Text("LOCATION").font(.system(size: 60))
                        .foregroundColor(.launchesTextColor)
                    Text(launch.locationName).font(.system(size: 60, weight: .semibold))
                        .foregroundColor(Color(.label))
                    
                }.padding(.all,40)
                    .frame(width: 640, height: 1080, alignment: .leading)
                    .background(Color.launchesSurfaceColor)
                
            }
            .transition(.opacity.animation(.easeInOut(duration:1.0)))  // fade when launch updates
                .id("Ops" + "\(launchIndex)") // create a changing ID so transition() will update all subviews
        }
    }
}




