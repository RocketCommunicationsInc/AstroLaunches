//
//  GiantLaunchCountdown.swift
//  Astro Launches TV
//
//  Created by rocketjeff on 3/17/22.
//

import SwiftUI

// a super-sized and simplified version of the LaunchCountdown view
struct GiantLaunchCountdown: View {
    var launch:Launch
    
    @State var timeRemaining: TimeInterval = 0

    // defaults sizes can be overridden
    var digitStyle:Font.TextStyle = .body
    
    var body: some View {
        HStack {
            HStack(spacing:2)
            {
                let digitFont = Font.system(size: 90).weight(.semibold).monospacedDigit()
                   
                Text(timeRemaining.days()+"  ")
                        .font(digitFont)

                Text(timeRemaining.hours()+":")
                        .font(digitFont)

                Text(timeRemaining.minutes()+":")
                        .font(digitFont)
                
                Text(timeRemaining.seconds())
                        .font(digitFont)
                
            }
            .foregroundColor(Color(.label))
            .onReceive(centralTimer) { _ in
                    // refresh the time every second
                    calcTimeRemaining()
                }
            .onAppear {
                    // refresh the time when first shown
                    calcTimeRemaining()
                }
            .onChange(of: launch) { newLaunch in // on change of coordinates, update our related state variable 'region'
                calcTimeRemaining(newlaunch:newLaunch) // must pass in the new launch, as the launch property is not set yet
            }
            
        }
    }
    
    func calcTimeRemaining(newlaunch:Launch)
    {
        timeRemaining = Date().timeIntervalSince(newlaunch.windowOpenDate!)
    }

    func calcTimeRemaining()
    {
        timeRemaining = Date().timeIntervalSince(launch.windowOpenDate!)
    }
}


