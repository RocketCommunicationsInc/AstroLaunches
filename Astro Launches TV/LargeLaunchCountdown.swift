//
//  LargeLaunchCountdown.swift
//  Astro Launches TV
//
//  Created by rocketjeff on 10/7/21.
//

import SwiftUI

struct LargeLaunchCountdown: View {
    var launch:Launch

    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    @State var timeRemaining: TimeInterval = 0

    var body: some View {
        HStack {
            VStack(alignment: .trailing)
                {
                    Text(timeRemaining.stringFromTimeInterval())
                        .font(.system(size:80,weight:.semibold, design: .monospaced))
                        .onReceive(self.timer) { _ in
                            self.timeRemaining = LargeLaunchCountdown.calcRemainingTime(launchDate:launch.windowOpenDate!)
                                    }
                    Text("       DAYS                   HRS                   MIN                    SEC")
                        .font(.system(size:24))

                }.foregroundColor(Color(.label))
                
            
        }
    }
    

    static func calcRemainingTime(launchDate:Date)->TimeInterval
    {
        let interval = Date().timeIntervalSince(launchDate)
        return interval

       // return launchDate
    }
}

extension TimeInterval{

        func stringFromTimeInterval() -> String {

            let time = NSInteger(self)

            let seconds = abs(time % 60)
            let minutes = abs((time / 60) % 60)
            let hours = abs((time / 3600) % 24)
            let days = abs((time / 86400))
            
            return String(format: "%0.2d %0.2d %0.2d %0.2d",days, hours,minutes,seconds)

        }
    }

struct LargeLaunchCountdown_Previews: PreviewProvider {
    static var networkManager = NetworkManager()
    static var previews: some View {
        LargeLaunchCountdown(launch:networkManager.launches[0])
            .previewLayout(.sizeThatFits)
        LargeLaunchCountdown(launch:networkManager.launches[1])
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
        LargeLaunchCountdown(launch:networkManager.launches[4])
            .previewLayout(.sizeThatFits)
    }
}


