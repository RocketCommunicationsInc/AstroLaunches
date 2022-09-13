//
//  ColorSchemeAutomatic.swift
//
//  Created by Jeff Hokit on 1/22/22.
//

import Foundation
import SwiftUI


// A variety of utilities to switch a View among automatic (system), light, and dark color schemes.
//
// The problem:
// The system enum ColorScheme only has light and dark values.

//
// The solutions:
// Provide an enum, ToolbarContent, and an AppStorage value that support switching among automatic (system), light, and dark schemes.
//
// Note that many solutions try to use "@Environment(\.colorScheme) var colorScheme" to detect the system theme, but this actually returns the current view's scheme.
// Once the view's scheme has been manually set to light or dark, (\.colorScheme) will return light or dark, regardless of the system's scheme.
// The best solution is to leave a view's color scheme unmodified to use the system scheme.

// An enum that adds automatic mode, missing from ColorScheme
public enum ColorSchemeAutomatic:Int{
    case automatic
    case light
    case dark
}

// Set the entire app scheme by attaching this to the highest level container view...
// Usage:
//    .preferredColorScheme(colorSchemeAutomatic == .light ? .light : colorSchemeAutomatic == .dark ? .dark : nil)


// The name of the AppStorage item that holds and stores the selected ColorSchemeAutomatic value.
// Usage:
//      @AppStorage(colorSchemeAutomaticName) var colorSchemeAutomatic:ColorSchemeAutomatic = .automatic
public let colorSchemeAutomaticName = "ColorSchemeAutomatic"


// ToolbarContent that adds a ToolbarItem and emits a menu to switch color schemes
// Usage:
//               .toolbar {
//                   ColorSchemeAutomaticToolbarContent()
//                }
// * note that the view containing the toolbar should also declare...
//    @AppStorage(colorSchemeAutomaticName) var colorSchemeAutomatic:ColorSchemeAutomatic = .automatic
public struct ColorSchemeAutomaticToolbarContent: ToolbarContent  {
    var placement:ToolbarItemPlacement = .automatic
  
    @AppStorage(colorSchemeAutomaticName) var colorSchemeAutomatic:ColorSchemeAutomatic = .automatic  // must also be declared in our parent view to receive automatic updates

    public init(placement:ToolbarItemPlacement){
        self.placement = placement
    }
    
    public init(){
    }

    public var body: some ToolbarContent {
        ToolbarItem(placement: placement)  {

            Menu(content: {
                
                Button(action : {
                    colorSchemeAutomatic = .automatic
                }) {
                    if colorSchemeAutomatic == .automatic {
                        Label("Automatic", systemImage:"checkmark")
                    }
                    else {
                        Text("Automatic")
                    }
                }
                
                Button(action : {
                    colorSchemeAutomatic = .light
                }) {
                    if colorSchemeAutomatic == .light {
                        Label("Light", systemImage:"checkmark")
                    }
                    else {
                        Text("Light")
                    }
                }

                Button(action : {
                    colorSchemeAutomatic = .dark
                }) {
                    if colorSchemeAutomatic == .dark {
                        Label("Dark", systemImage:"checkmark")
                    }
                    else {
                        Text("Dark")
                    }
                }
            })
            {
                Image(systemName: "circle.righthalf.filled")
            }
        }
    }
}
