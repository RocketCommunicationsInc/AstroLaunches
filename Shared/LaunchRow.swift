//
//  LaunchRow.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/18/21.
//

import SwiftUI

struct LaunchRow: View {
    
    var launch:Launch
    
    var body: some View {
        VStack {
            Image("launch").resizable().frame(minWidth: 10, idealWidth: 100, maxWidth: .infinity, minHeight: 10, idealHeight: 100, maxHeight: 100, alignment: .center)
            Text(launch.name)

        }
    }
}

struct LaunchRow_Previews: PreviewProvider {
    
    static let launchPreview = Launch(name: "Starlink-23")
    static var previews: some View {
        LaunchRow(launch:launchPreview)
    }
}
