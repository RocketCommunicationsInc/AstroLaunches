//
//  LaunchCountdown.swift
//  Astro Launches
//
//  Created by rocketjeff on 10/7/21.
//

import SwiftUI

struct LaunchCountdown: View {
    var launch:Launch
    
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
                    Text(timeRemaining.days())
                        .font(digitFont)
                    Text("DAYS")
                        .font(labelFont)
                }
                
                VStack (alignment: .trailing){
                    Text(timeRemaining.hours())
                        .font(digitFont)
                    Text("HRS")
                        .font(labelFont)
                }
                
                VStack (alignment: .trailing){
                    Text(timeRemaining.minutes())
                        .font(digitFont)
                    Text("MIN")
                        .font(labelFont)
                }
                
                VStack (alignment: .trailing){
                    Text(timeRemaining.seconds())
                        .font(digitFont)
                    Text("SEC")
                        .font(labelFont)
                }
                
            }.foregroundColor(Color(.label))
            .onReceive(centralTimer) { _ in
                    // refresh the time every second
                    calcTimeRemaining()
                }
            .onAppear {
                    // refresh the time when first shown
                    calcTimeRemaining()
                }
        }
    }
    

    func calcTimeRemaining()
    {                                                               timeRemaining = Date().timeIntervalSince(launch.windowOpenDate!)
    }
}

// extend TimeInterval to output units of time as Strings, always with two digits
extension TimeInterval{
    
    func days()->String {
        
        let time = NSInteger(self)
        let days = abs((time / 86400))
        
        return String(format: "%0.2d",days)
    }
    
    func hours()->String {
        
        let time = NSInteger(self)
        let hours = abs((time / 3600) % 24)

        return String(format: "%0.2d",hours)
    }
    
    func minutes()->String {
        
        let time = NSInteger(self)
        let minutes = abs((time / 60) % 60)

        return String(format: "%0.2d",minutes)
    }
    
    func seconds()->String {
        
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

