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

    var body: some View {
        if let launch = networkManager.launches.first
        {
            HStack(spacing:0) {
                if let imageURL = launch.imageURL
                {
                    ZStack(alignment:.leading) {
                        WebImage(url: imageURL)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 1280, height: 1080, alignment: .topLeading)
                            .clipped()
                            .blur(radius:4)
                        
                        HStack(alignment: .center) {
                            if let url = launch.agency?.logoURL
                            {
                                WebImage(url:url)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300, height: 300,alignment: .center)
                                    .background(Color.launchesSurfaceColor)
                                    .padding()
                            }

//                            Image("AstroLogoLarge").frame(width: 300, height: 300).background(Color.launchesCardColor)
                            VStack(alignment: .leading)
                            {
                                Text(launch.missionName)
                                    .font(.system(size: 100
                                                  
                                                  , weight: .semibold, design: .default))
                                    .padding()
                                Countdown(launch:launch)
                                    .padding()
                            }.padding(.leading,40)
                            
                        }.frame(width: 1280)
                    }
                }
                VStack(alignment: .leading) {
                 //   Image("AstroLogoLarge")
                    Group {
                        Text("ROCKET").font(.system(size: 24))
                            .foregroundColor(.launchesTextColor)
                        Text(launch.rocketName).font(.system(size: 32))
                            .foregroundColor(.white)
                    }
                    Divider()
                    
                    Group {
                        Text("LOCATION").font(.system(size: 24))                                .foregroundColor(.launchesTextColor)
                        Text(launch.locationName).font(.system(size: 32))                                .foregroundColor(.white)
                    }
                    Divider()

                    Group {
                        Text("MISSION").font(.system(size: 24))                                .foregroundColor(.launchesTextColor)
                        Text(launch.missionDescription).font(.system(size: 32))                                .foregroundColor(.white)
                    }
                    Divider()

                    Group {
                        Text("STATUS").font(.system(size: 24))                                .foregroundColor(.launchesTextColor)
                        if let status = launch.status
                        {
                            StatusTag(text: status,status: launch.astroStatus)
                        }
                    }
                    Divider()

                }.padding(.all,40)
                    .frame(width: 640, height: 1080, alignment: .leading)
                    .background(Color.launchesSurfaceColor)
                
                
            }
        }
    }
}


struct Countdown: View {
  //  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var launch:Launch

    var body: some View {
        HStack {
            if let windowOpenDate = launch.windowOpenDate
            {
                HStack {
                    Text("T-")
                        .font(.system(size: 90
                                      , weight: .semibold, design: .default))
                    .foregroundColor(.white)
                    
                    Text(windowOpenDate, style: .timer)
                        .foregroundColor(.white)
                        .font(.system(size: 80, weight: .semibold,design: .monospaced))

                }.padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(6)
                
            }
        }
    }
}

struct ConferenceRoomView_Previews: PreviewProvider {
    static var networkManager = NetworkManager()

    static var previews: some View {
        ConferenceRoomView(networkManager: networkManager)
    }
}



