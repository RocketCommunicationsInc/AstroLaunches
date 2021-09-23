//
//  Colors.swift
//  Astro Launches
//
//  Created by rocketjeff on 9/22/21.
//

import Foundation
import SwiftUI

public extension Color
{

    // based on a similar function for UIColor at https://stackoverflow.com/questions/56487679/how-do-i-easily-support-light-and-dark-mode-with-a-custom-color-used-in-my-app
    static func dynamicColor(light: Color, dark: Color) -> Color {
        @Environment(\.colorScheme) var colorScheme // iOS 15.0, always returns light

        if (colorScheme == .dark)
        {
            return dark
        }
        else
        {
            return light
        }
       // return Color { colorScheme == .dark ? dark : light }
    }

    //——————————————————————————————————————————————————————————————————————————————
    // Semantic UI colors
    //——————————————————————————————————————————————————————————————————————————————
    static var launchesTextColor:Color
    {return Color("Text Color")} // astroUIPrimaryLighten4,astroUITertiaryLighten1
    
    static var launchesBackgroundColor:Color
    {return Color("Background Color")} //

    static var launchesCardColor:Color
    {return Color("Card Color")} //
    
    static var launchesTagBorderColor:Color
    {return Color("Tag Border")} // not Astro colors

    static var launchesTagBackgroundColor:Color
    {return Color("Tag Background")} //astroUIPrimaryLighten2,astroUISecondaryLighten4

//    static var launchesTextColor:Color
//    {
//        @Environment(\.colorScheme) var colorScheme // iOS 15.0, always returns light
//
//        if (colorScheme == .dark)
//        {
//            return .astroUITertiaryLighten1
//        }
//        else
//        {
//            return .astroUIPrimaryLighten4
//        }
//    }
}
