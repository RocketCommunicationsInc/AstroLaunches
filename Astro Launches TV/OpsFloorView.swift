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
    @State var launchIndex = 0

    // every 15 seconds publish a message that will cause an update to the next launch
    let timer = Timer.publish(every: 15, on: .current, in: .common).autoconnect()

    var body: some View {
        if networkManager.launches.count > 0
        {

        let launch = networkManager.launches[launchIndex]
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
                                .font(.system(size: 90, weight: .semibold, design: .default))
                                .padding()
                                .background(.thickMaterial)
                                .cornerRadius(6)

                            GiantLaunchCountdown(launch:launch)
                                .padding()
                                .background(.thickMaterial)
                                .cornerRadius(6)

                                //.padding()
                        }.padding(.leading,40)//.frame(width: 1280)
                    }
                }
                VStack(alignment: .leading) {
                    Text("ROCKET").font(.system(size: 60))                            .foregroundColor(.launchesTextColor)
                        .focusable(true) // attract the automatic focus when swiftui loads this view
                    Text(launch.rocketName).font(.system(size: 60, weight: .semibold))                                .foregroundColor(Color(.label))
                    Spacer()
                    
                    Text("STATUS").font(.system(size: 60))                                .foregroundColor(.launchesTextColor)
                    if let status = launch.status
                    {
                        TitleStatusTag(text: status,status: launch.astroStatus)
                    }
                    Spacer()
                    
                    Text("LOCATION").font(.system(size: 60))                                .foregroundColor(.launchesTextColor)
                    Text(launch.locationName).font(.system(size: 60, weight: .semibold))                                .foregroundColor(Color(.label))

                }.padding(.all,40)
                    .frame(width: 640, height: 1080, alignment: .leading)
                    .background(Color.launchesSurfaceColor)
                
            }          .transition(.opacity.animation(.easeInOut(duration:1.0)))
            .id("Ops" + "\(launchIndex)")
        //.animation(Animation.easeInOut, value: launchIndex) // uncomment to animate the change. Its a bit much
        .onReceive(self.timer) { _ in
            // When receiving the 15 second timer, advance to the next launchIndex, wrapping around.
            // Note that this will cause a runtime warning  "Modifying state during view update, this will cause undefined behavior."
            // I have not found any workaround for this, including putting the launchIndex on another thread.
            // This is a common pattern to update the view, seen throuhout the SwiftUI literature. Not sure why the warning happens
            // here, maybe because the update is so major, a whole screenful of content?
            launchIndex = (launchIndex + 1)  % networkManager.launches.count
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
                let digitFont = Font.system(size: 90).weight(.semibold).monospacedDigit()

                HStack {
                    Text(windowOpenDate, style: .timer)
                        .foregroundColor(Color(.label))
                        .font(digitFont)

                }.padding()
                    .background(.thickMaterial)
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



