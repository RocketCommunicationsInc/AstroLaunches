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
    @State var launchIndex = 0
    
    let timer = Timer.publish(every: 5, on: .current, in: .common).autoconnect()
   
    var body: some View {

        if networkManager.launches.count > 0
        {
        let launch = networkManager.launches[launchIndex]

        // HStack for the whole screen
            HStack(spacing:0) {
                ZStack(alignment:.leading) {
                    WebImage(url: launch.imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 1280, height: 1080, alignment: .topLeading)
                        .clipped()
                        .blur(radius:4)
                    
                    VStack(alignment:.leading,spacing: 100) {
                        LogoNameCountdown(launch:launch)
                        HStack{
                            LaunchCalendar(launch:launch, labelStyle:.headline)
                            LaunchClock(launch:launch, labelStyle:.headline)
                        }
                    }.padding(.leading, 80)
                }
                Sidebar(launch: launch)
            }
          //  .animation(Animation.easeInOut, value: launchIndex)
            .onReceive(self.timer) { _ in
                launchIndex = (launchIndex + 1)  % networkManager.launches.count
            }
        }
    }
}


struct Sidebar: View {
    var launch:Launch

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Spacer()

                Text("ROCKET").font(.system(size: 24))
                    .foregroundColor(.launchesTextColor)
                Text(launch.rocketName).font(.system(size: 32))
                    .foregroundColor(.white)
                Spacer()
                Divider()


            }
            Group {
                Spacer()

                Text("LOCATION").font(.system(size: 24))                                .foregroundColor(.launchesTextColor)
                Text(launch.locationName).font(.system(size: 32))                                .foregroundColor(.white)
                PadMap(coord:launch.locationCoordinate).frame(minHeight:100,idealHeight: 175).cornerRadius(6)
                Spacer()
                Divider()

            }
            Group {
                Spacer()

                Text("MISSION").font(.system(size: 24))                                .foregroundColor(.launchesTextColor)
                Text(launch.missionDescription).font(.system(size: 32))                                .foregroundColor(.white)
                Spacer()
                Divider()
            }
            Group {
                Spacer()

                Text("STATUS").font(.system(size: 24))                                .foregroundColor(.launchesTextColor)
                if let status = launch.status
                {
                    StatusTag(text: status,status: launch.astroStatus)
                }

            }
            Spacer()
        }.padding(.all,40)
            .frame(width: 640, height: 1080, alignment: .leading)
            .background(Color.launchesSurfaceColor)
    }
}



struct LogoNameCountdown: View {
    var launch:Launch

    var body: some View {
        HStack(alignment: .bottom) {
            if let url = launch.agency?.logoURL
            {
                WebImage(url:url)
                    .resizable()
                    .padding()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300,alignment: .center)
                    .background(Color.launchesBackgroundColor)
                    .cornerRadius(6)
            }
            
            VStack(alignment: .leading)
            {
                let titleFontSize = UIFont.preferredFont(forTextStyle: .title1).pointSize
                
                Text(launch.missionName)
                    .font(.system(size: titleFontSize * 1.2, weight: .semibold))
                    .padding()
                LaunchCountdown(launch:launch, digitStyle: .title, labelStyle: .caption)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(6)
            }
            Spacer()
        }//.frame(width: 1280)
    }
}



struct ConferenceRoomView_Previews: PreviewProvider {
    static var networkManager = NetworkManager()

    static var previews: some View {
        ConferenceRoomView(networkManager: networkManager)
    }
}



