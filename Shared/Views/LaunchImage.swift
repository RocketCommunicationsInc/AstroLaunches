//
//  LaunchImage.swift
//  Astro Launches (iOS)
//
//  Created by rocketjeff on 4/1/22.
//

import SwiftUI
import CachedAsyncImage
import AstroSwiftFoundation

struct LaunchCardImage: View {
    
    var launch:Launch
    var height:CGFloat
    var body: some View {
        ZStack(alignment:.bottom){
            // Image or placehoder
            if let imageURL = launch.imageURL
            {
                CachedAsyncImage(url:imageURL , content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: height, maxHeight: height, alignment: .top)
                        .clipped()
                }, placeholder: {
                    ProgressView()
                }).frame(height: height)
            }
            else { // no image available, use our stock photo
                Image("launch")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: height, idealHeight: height, maxHeight: height, alignment: .top)
                    .clipped()
            }
            
            // Overlay some items over the image
            VStack{
                PlayButtonBlock(launch:launch)
                Spacer() // force the LogoCountdownBlock to the bottom
                LogoCountdownBlock(launch: launch)
            }
        }
    }
}


struct LaunchDetailImage: View {
    
    var launch:Launch
    var body: some View {
        ZStack(alignment:.bottom){
            // Image or placehoder
            if let imageURL = launch.imageURL
            {
                // the actual image
                CachedAsyncImage(url:imageURL, content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                }, placeholder: {
                    ProgressView()
                })
            }
            else { // no image available, use our stock photo
                Image("launch")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            }
            
            // Overlay some items over the image
            VStack{
                PlayButtonBlock(launch:launch)
                Spacer() // force the LogoCountdownBlock to the bottom
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
                    Label(launch.webcast ? "Watch Live" : "Watch", systemImage: "video.fill").background(.clear)
                }.buttonStyle(.borderless)
                    .font(.caption)
                    .padding(6)
                    .background(.thinMaterial, in:RoundedRectangle(cornerRadius: 6)) // add RoundedRectangle to background color to set the shape of this borderless button
            }
        }.padding(6) // inset from the top right
    }
}


struct LogoCountdownBlock: View {
    var launch:Launch
    var body: some View {
        // the info row, with the logo, and optional countdown, with a material background
        HStack() {
            if let url = launch.agency?.logoURL
            {
                CachedAsyncImage(url:url, content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                }, placeholder: {
                    ProgressView()
                })
                .frame(width: 40, height: 40)
                .padding([.top, .bottom], 2)
                .padding(.leading, 8)
            }
            Spacer()
            // only show countown for launches in the future
            if let windowOpenDate = launch.windowOpenDate
            {
                IntervalTimer(targetDate: windowOpenDate,options: .all)
#if os(iOS)
                    .foregroundColor(Color(.label))
#endif
#if os(macOS)
                    .foregroundColor(Color(.labelColor))
#endif
                    .padding(.trailing, 8)
                    .padding(.top, 2)
                    .padding(.bottom, 2)
            }
        }
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
    }
}

