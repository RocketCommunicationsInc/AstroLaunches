//
//  ContentView.swift
//  Astro Launches TV
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI
import AstroSwiftFoundation
import SDWebImageSwiftUI

struct OpsFloorView: View {
    
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
                            .blur(radius:2)
                        
                        VStack(alignment: .leading)
                        {
                            Text(launch.missionName)
                                .font(.system(size: 90
                                              , weight: .semibold, design: .default))
                                .padding()
                            GiantCountdown(launch:launch)
                                .padding()
                        }.padding(.leading,40)//.frame(width: 1280)
                    }
                }
                VStack(alignment: .leading) {
                    Image("AstroLogoLarge")
                    Spacer()
                    Text("ROCKET").font(.system(size: 60))                                .foregroundColor(.launchesTextColor)
                    Text(launch.rocketName).font(.system(size: 60))                                .foregroundColor(Color(.label))
                    Spacer()
                    
                    Text("STATUS").font(.system(size: 60))                                .foregroundColor(.launchesTextColor)
                    if let status = launch.status
                    {
                        TitleStatusTag(text: status,status: launch.astroStatus)
                    }
                    Spacer()
                    
                    Text("LOCATION").font(.system(size: 60))                                .foregroundColor(.launchesTextColor)
                    Text(launch.locationName).font(.system(size: 60))                                .foregroundColor(Color(.label))

                }.padding(.all,40)
                    .frame(width: 640, height: 1080, alignment: .leading)
                    .background(Color.launchesSurfaceColor)
                
                
            }
        }
    }
}


struct GiantCountdown: View {
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
                    .foregroundColor(Color(.label))
                    
                    Text(windowOpenDate, style: .timer)
                        .foregroundColor(Color(.label))
                        .font(.system(size: 90, weight: .semibold,design: .monospaced))

                }.padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(6)
                
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var networkManager = NetworkManager()

    static var previews: some View {
        OpsFloorView(networkManager: networkManager)
    }
}



