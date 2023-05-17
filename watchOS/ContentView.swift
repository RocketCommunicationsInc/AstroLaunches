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
        GeometryReader { proxy in
            ZStack{
                ScrollView {
                    LazyVStack() {
                        ForEach(timeSpan == .upcoming ? networkManager.upcomingLaunches : networkManager.pastLaunches, id: \.id) { launch in
                            NavigationLink {
                                LaunchDetail(launch: launch)
                            } label: {
                                LaunchCard(launch:launch, height:proxy.size.height) // make the LaunchCard fit the available area for any screen size
                                    .padding(.top,3)
                                    .padding(.bottom,3)
                                    .padding(.leading,6)
                                    .padding(.trailing,6)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
                
                // if no data is available show a ProgressView
                let zeroData = timeSpan == .upcoming ? networkManager.upcomingLaunches.count == 0 : networkManager.pastLaunches.count == 0
                ProgressView()
                    .opacity(zeroData ? 1 : 0)
            }.navigationTitle("Launches")
        }
    }
    

    
    struct LaunchCard: View {
        var launch:Launch
        var height:CGFloat
        
        var body: some View {
            ZStack() {
                // Launch Image and Countdown clock
                Text(launch.missionName)
                    .font(.body)
                    .padding()
                
                LaunchCardImage(launch: launch, height: height)
                
                VStack{
                    Text(launch.missionName)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()

                    Spacer()
                    
                    // only show countown for launches in the future
                    if let windowOpenDate = launch.windowOpenDate
                    {
                        IntervalTimer(targetDate:windowOpenDate,digitTextStyle: .caption2, labelFontStyle: .footnote)
                            .frame(maxWidth: .infinity)
                            .padding(4)
                            .background(Color.init(white: 0.4, opacity: 0.5))
                    }
                }
            }
            .cornerRadius(6)
            .foregroundColor(.primary) // text color, this is not set by default on watchOS
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
                    }, placeholder: { // image still loading, use a simple rectangle fill + ProgressView
                        ZStack{
                            Rectangle()
                                .foregroundColor(.astroUIBackground)
                                .frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: height, maxHeight: height, alignment: .top)
                            ProgressView()
                        }
                    }).frame(height: height)
                }
                else { // no image available, use a simple rectangle fill
                    Rectangle()
                        .foregroundColor(.astroUIBackground)
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: height, idealHeight: height, maxHeight: height, alignment: .top)
                        .clipped()
                }
            }
        }
    }
}


