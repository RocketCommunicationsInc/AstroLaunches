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
                    ZStack {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 1280, height: 1080, alignment: .topLeading)
                            .clipped()
                        
                        VStack
                        {
                            Spacer()
                            HStack {
                                Text(launch.missionName)
                                    .padding()
                                    .font(.system(size: 90
                                                  , weight: .semibold, design: .default))
                                    .frame(alignment: .leading)
                                Spacer()
                                Text("T- 00:00:00")
                                    .padding()
                                    .font(.system(size: 90
                                                  , weight: .semibold, design: .default))
                            }
                            .frame(width: 1280, alignment: .leading)
                            .background(.ultraThinMaterial)
                        }.frame(width: 1280)
                    }
                }
                VStack {
                    Image("AstroLogoLarge")
                }.padding()
                    .frame(width: 640, height: 1080, alignment: .leading)
                    .background(Color.launchesCardColor)
                
                
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



