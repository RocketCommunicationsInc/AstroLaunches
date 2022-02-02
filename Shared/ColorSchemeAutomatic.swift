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
// The system ViewModifier preferredColorScheme only allows light and dark values.
// To use the system's current color scheme, a view must be unmodified. There is no value that can be passed to preferredColorScheme to choose the system scheme
//
// The solutions:
// Provide an enum, ViewModifier, ToolbarContent, and an AppStorage value that support switching among automatic (system), light, and dark schemes.
//
// Note that many solutions try to use "@Environment(\.colorScheme) var colorScheme" to detect the system theme, but this actually returns the current view's scheme.
// Once the view's scheme has been manually set to light or dark, (\.colorScheme) will return light or dark, regardless of the system's scheme.
// The best solution is to leave a view's color scheme unmodified to use the system theme.

// An enum that adds automatic mode, missing from ColorScheme
public enum ColorSchemeAutomatic:Int{
    case automatic
    case light
    case dark
}

// The name of the AppStorage item that holds and stores the selected ColorSchemeAutomatic value.
// Usage:
//      @AppStorage(colorSchemeAutomaticName) var colorSchemeAutomatic:ColorSchemeAutomatic = .automatic
public let colorSchemeAutomaticName = "ColorSchemeAutomatic"


// A ViewModifier that applies the current value to a view
// Usage:
//      .modifier(colorSchemeAutomatic())
public struct colorSchemeAutomatic: ViewModifier {
    @AppStorage(colorSchemeAutomaticName) var colorSchemeAutomatic:ColorSchemeAutomatic = .automatic
    
    public init(){
    }

    public func body(content: Content) -> some View {
        if (colorSchemeAutomatic == .light) {
            content.preferredColorScheme(.light)
        }
        else if (colorSchemeAutomatic == .dark) {
            content.preferredColorScheme(.dark)
        }
        else { // automatic
            content // return the unmodified view content
        }
    }
}

// ToolbarContent that adds a ToolbarItem and emits a menu to switch color schemes
//               .toolbar {
//                   ColorSchemeAutomaticToolbarContent()
//                }
public struct ColorSchemeAutomaticToolbarContent: ToolbarContent  {
    var placement:ToolbarItemPlacement = .automatic
    @AppStorage(colorSchemeAutomaticName) var colorSchemeAutomatic:ColorSchemeAutomatic = .automatic

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
