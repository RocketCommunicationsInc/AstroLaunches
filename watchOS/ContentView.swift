//
//  ContentView.swift
//  Astro Launches Watch App
//
//  Created by Jeff Hokit on 9/16/22.
//

import SwiftUI
import CachedAsyncImage
import AstroSwiftFoundation

struct ContentView: View {
    @ObservedObject var networkManager: NetworkManager
    @AppStorage("TimePeriod") private var timeSpan:TimePeriod = .upcoming

    var body: some View {
        LaunchStack(networkManager: networkManager, timePeriod: .upcoming)
    }
    
    struct LaunchStack: View {
        @ObservedObject var networkManager: NetworkManager
        var timePeriod:TimePeriod
        
        var body: some View {
            ZStack{
                ScrollView {
                    LazyVStack() {
                        ForEach(timePeriod == .upcoming ? networkManager.upcomingLaunches : networkManager.pastLaunches, id: \.id) { launch in
                            NavigationLink {
                                Text(launch.missionDescription)

                               // LaunchDetail(launch: launch)
                            } label: {
                                LaunchCard(launch:launch)
                                    .padding(.top,3)
                                    .padding(.bottom,3)
                                    .padding(.leading,6)
                                    .padding(.trailing,6)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .listRowBackground(Color.astroUISecondaryBackground) // *** Astro customization
                        }
                    }
                }.background(Color.astroUIBackground) // *** Astro customization
                
                // if no data is available show a ProgressView
                let zeroData = timePeriod == .upcoming ? networkManager.upcomingLaunches.count == 0 : networkManager.pastLaunches.count == 0
                ProgressView().opacity(zeroData ? 1 : 0)
            }
            
        }
    }
    
    struct LaunchCard: View {
        
        var launch:Launch
        
        var body: some View {
            VStack(spacing:0) {
                // Launch Image and Countdown clock
                Text(launch.missionName)
                    .font(.body)
                    .foregroundColor(.white)
                    .padding()
                LaunchCardImage(launch: launch, height: 160)
                // only show countown for launches in the future
                if let windowOpenDate = launch.windowOpenDate
                {
                    IntervalTimer(targetDate:windowOpenDate,digitTextStyle: .caption2, labelFontStyle: .footnote)
                        .foregroundColor(.white)
                        .padding()
                }

            }.background(Color.astroUISecondaryBackground).cornerRadius(6)
        }
        
    }
    
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
                    Rectangle()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: height, idealHeight: height, maxHeight: height, alignment: .top)
                        .clipped()
                }
                
//                // Overlay some items over the image
//                VStack{
//                    Spacer() // force the LogoCountdownBlock to the bottom
//                    Countdown(launch: launch)
//                }
            }
        }
    }
    
    struct Countdown: View {
        var launch:Launch
        var body: some View {
            // the info row, with the logo, and optional countdown, with a material background
            HStack()
            {
                Spacer()
                // only show countown for launches in the future
                if let windowOpenDate = launch.windowOpenDate
                {
                    IntervalTimer(targetDate:windowOpenDate)
                }
            }
            .frame(maxWidth: .infinity)
            .background(.black)
        }
    }


}


