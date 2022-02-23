//
//  Colors.swift
//  Astro Launches
//
//  Created by rocketjeff on 9/22/21.
//

import Foundation
import SwiftUI
import AstroSwiftFoundation

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
    }

    //——————————————————————————————————————————————————————————————————————————————
    // New Astro Colors, not yet in Foundation
    //——————————————————————————————————————————————————————————————————————————————
    //MARK: Color - Astro Status colors
    //——————————————————————————————————————————————————————————————————————————————
    // Astro status colors
    //——————————————————————————————————————————————————————————————————————————————
//    static var astroStatusBorderOff:Color
//    {  return Color("Astro Status Off Border Color")}
//    
//    static var astroStatusBorderStandby:Color
//    { return Color("Astro Status Standby Border Color")}
//
//    static var astroStatusBorderNormal:Color
//    { return Color("Astro Status Normal Border Color")}
//    
//    static var astroStatusBorderCaution:Color
//    { return Color("Astro Status Caution Border Color")}
//    
//    static var astroStatusBorderSerious:Color
//    { return Color("Astro Status Serious Border Color")}
//    
//    static var astroStatusBorderCritical:Color
//    { return Color("Astro Status Critical Border Color")}
//
//
//    static func borderColorForAstroStatus(_ status:AstroStatus)->Color
//    {
//        switch status {
//        case .Off:
//            return Color.astroStatusBorderOff
//        case .Standby:
//            return Color.astroStatusBorderStandby
//        case .Normal:
//            return Color.astroStatusBorderNormal
//        case .Caution:
//            return Color.astroStatusBorderCaution
//        case .Serious:
//            return Color.astroStatusBorderSerious
//        case .Critical:
//            return Color.astroStatusBorderCritical
//        }
//    }
//    
    static var astroStatus200Off:Color
    {  return Color("Astro Status Off 200 Color")}
    
    static var astroStatus200Standby:Color
    { return Color("Astro Status Standby 200 Color")}

    static var astroStatus200Normal:Color
    { return Color("Astro Status Normal 200 Color")}
    
    static var astroStatus200Caution:Color
    { return Color("Astro Status Caution 200 Color")}
    
    static var astroStatus200Serious:Color
    { return Color("Astro Status Serious 200 Color")}
    
    static var astroStatus200Critical:Color
    { return Color("Astro Status Critical 200 Color")}


    static func color200ForAstroStatus(_ status:AstroStatus)->Color
    {
        switch status {
        case .Off:
            return Color.astroStatus200Off
        case .Standby:
            return Color.astroStatus200Standby
        case .Normal:
            return Color.astroStatus200Normal
        case .Caution:
            return Color.astroStatus200Caution
        case .Serious:
            return Color.astroStatus200Serious
        case .Critical:
            return Color.astroStatus200Critical
        }
    }
    
    
    //——————————————————————————————————————————————————————————————————————————————
    // Semantic UI colors for this app, should be elevated to Foundation
    //——————————————————————————————————————————————————————————————————————————————
    static var launchesTextColor:Color
    {return Color("Text Color")} // astroUIPrimaryLighten4,astroUITertiaryLighten1
    
    static var launchesBackgroundColor:Color
    {return Color("Background Color")} //

    static var launchesSurfaceColor:Color
    {return Color("Surface Color")} //
    
    static var launchesBoxColor:Color
    {return Color("Box Color")} //

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
