//
//  ImageBlock.swift
//  Astro Launches (iOS)
//
//  Created by rocketjeff on 4/1/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageBlock: View {
    
    var launch:Launch
    var height:CGFloat
    var showStatus:Bool
    var wide = false
    var body: some View {
        
        ZStack(alignment:.bottom){
            // Image, or placehoder
            if let imageURL = launch.imageURL
            {
                ZStack(alignment:.topTrailing) {
                    if (wide) // wide mode for display on ipad detail screen
                    {
                        // put a full width blurred image in the background, to fill space that the image might not cover
                        WebImage(url:imageURL)
                            .resizable()
                            .indicator(.activity)
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: 10, maxHeight: height, alignment: .top)
                            .blur(radius:8)
                            .clipped()
                        
                        // the actual image
                        WebImage(url:imageURL)
                            .resizable()
                            .indicator(.activity)
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: 10, maxHeight: height, alignment: .top)
                            .clipped()
                    }
                    else  // narrow mode for display on list view
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
            
            // Overlay some items over the image
            VStack{
                PlayButtonBlock(launch:launch)
                Spacer() // force the info row to the bottom
                LogoCountdownBlock(launch: launch)
            }
        }
    }
}



struct PlayButtonBlock: View {
    @Environment(\.openURL) var openURL
    var launch:Launch
    var body: some View {
        // At the top right of the image, a "Watch" button if video is available
        HStack{
            Spacer() //force the button to the right
            if let videoURL = launch.videoURL // if there is any video
            {
                Button(action: {
                    openURL(videoURL)
                }) {
                    if (launch.webcast){    // if the video is live
                        HStack {
                            Image(systemName: "video.fill")
                            Text("Watch Live")
                        }
                    }
                    else { // if the video is recorded
                        HStack {
                            Image(systemName: "video.fill")
                            Text("Watch")
                        }
                    }
                }.buttonStyle(.bordered).font(.caption).background(.regularMaterial)
            }
        }.padding(6)
    }
}


struct LogoCountdownBlock: View {
    var launch:Launch
    var body: some View {
        // the info row, with the logo, and optional countdown, with a material background
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

