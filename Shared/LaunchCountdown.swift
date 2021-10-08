//
//  LaunchCountdown.swift
//  Astro Launches
//
//  Created by rocketjeff on 10/7/21.
//

import SwiftUI

struct LaunchCountdown: View {
    var launch:Launch

    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    @State var timeRemaining: TimeInterval = 0
    
    // defaults sizes can be overridden
    var digitStyle:Font.TextStyle = .body
    var labelStyle:Font.TextStyle = .caption2
    
    var body: some View {
        HStack {
            HStack()
                {
                    let digitFont = Font.system(digitStyle).weight(.semibold).monospacedDigit()
                    let labelFont = Font.system(labelStyle)

                    VStack (alignment: .trailing){
                        Text(timeRemaining.daysFromTimeInterval())
                            .font(digitFont)
                        Text("DAYS")
                            .font(labelFont)
                    }

                    VStack (alignment: .trailing){
                        Text(timeRemaining.hoursFromTimeInterval())
                            .font(digitFont)
                        Text("HRS")
                            .font(labelFont)
                    }

                    
                    VStack (alignment: .trailing){
                        Text(timeRemaining.minutesFromTimeInterval())
                            .font(digitFont)
                        Text("MIN")
                            .font(labelFont)
                    }
                    
                    VStack (alignment: .trailing){
                        Text(timeRemaining.secondsFromTimeInterval())
                            .font(digitFont)
                        Text("SEC")
                            .font(labelFont)
                    }

                }.foregroundColor(Color(.label))
                .onReceive(self.timer) { _ in
                    self.timeRemaining = LaunchCountdown.calcRemainingTime(launchDate:launch.windowOpenDate!)
                            }
                
            
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
    
//    func stringFromTimeInterval() -> String {
//        
//        let time = NSInteger(self)
//        
//        let seconds = abs(time % 60)
//        let minutes = abs((time / 60) % 60)
//        let hours = abs((time / 3600) % 24)
//        let days = abs((time / 86400))
//        
//        return String(format: "%0.2d %0.2d %0.2d %0.2d",days, hours,minutes,seconds)
//    }
    
    func daysFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        let days = abs((time / 86400))
        
        return String(format: "%0.2d",days)
    }
    
    func hoursFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        let hours = abs((time / 3600) % 24)

        return String(format: "%0.2d",hours)
    }
    
    func minutesFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        let minutes = abs((time / 60) % 60)

        return String(format: "%0.2d",minutes)
    }
    
    func secondsFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        let seconds = abs(time % 60)

        return String(format: "%0.2d",seconds)
    }
}


struct LaunchCountdown_Previews: PreviewProvider {
    static var networkManager = NetworkManager()
    static var previews: some View {
        LaunchCountdown(launch:networkManager.launches[0])
            .previewLayout(.sizeThatFits)
        LaunchCountdown(launch:networkManager.launches[1])
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}

