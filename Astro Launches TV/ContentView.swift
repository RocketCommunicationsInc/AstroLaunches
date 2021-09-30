//
//  ContentView.swift
//  Astro Launches TV
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI
import AstroSwiftFoundation


struct ContentView: View {
    
    @ObservedObject var networkManager: NetworkManager

    var body: some View {
        if let launch = networkManager.launches.first
        {
            HStack(spacing:0) {
                if let image = launch.image
                {
                    ZStack(alignment:.leading) {
                        Image(uiImage: image)
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
                            Countdown(launch:launch)
                                .padding()
                        }.padding(.leading,40)//.frame(width: 1280)
                    }
                }
                VStack(alignment: .leading) {
                    Image("AstroLogoLarge")
                    Spacer()
                    Text("ROCKET").font(.system(size: 60))                                .foregroundColor(.launchesTextColor)
                    Text(launch.rocketName).font(.system(size: 60))                                .foregroundColor(.white)
                    Spacer()
                    
                    Text("STATUS").font(.system(size: 60))                                .foregroundColor(.launchesTextColor)
                    if let status = launch.status
                    {
                        GiantStatusTag(text: status,status: launch.astroStatus)
                    }
                    Spacer()
                    
                    Text("LOCATION").font(.system(size: 60))                                .foregroundColor(.launchesTextColor)
                    Text(launch.locationName).font(.system(size: 60))                                .foregroundColor(.white)

                }.padding(.all,40)
                    .frame(width: 640, height: 1080, alignment: .leading)
                    .background(Color.launchesCardColor)
                
                
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
        ContentView(networkManager: networkManager)
    }
}



