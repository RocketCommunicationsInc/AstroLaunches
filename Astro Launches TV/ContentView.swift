//
//  ContentView.swift
//  Astro Launches TV
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI
import AstroSwiftFoundation

struct ContentView: View {
    @ObservedObject var networkManager: NetworkManager

    var body: some View {
        NavigationView {
            List {
                ForEach(networkManager.launches, id: \.name) { launch in
                    NavigationLink(
                        destination: Text("Destination"),
                        label: {
                            LaunchRow(launch:launch)
                        }).listRowBackground(Color.astroUITableCell)
                }
                }
            }
        }
    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       Text("hello")// ContentView()
    }
}
