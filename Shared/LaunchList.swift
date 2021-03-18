//
//  ContentView.swift
//  Shared
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI
import CoreData
import AstroSwiftFoundation
#if os(iOS)
import SwiftUIListSeparator
#endif

//import Combine


struct LaunchList: View {
    
    @EnvironmentObject var networkManager: NetworkManager

    init(){
       // UIView.appearance().backgroundColor = UIColor.astroUIBackground
        // this causes the disappearing view bug

//        // These do nothing when the UIView backgroundColor is set above
//        UINavigationBar.appearance().barStyle = .default
//        UINavigationBar.appearance().isTranslucent = true
//        UINavigationBar.appearance().barTintColor = UIColor.red
//        UINavigationBar.appearance().backgroundColor = UIColor.red

    }
    
    var body: some View{
        
        //#if os(iOS)
        // must embed List within a NavigationView on iOS or .toolbar wont work
        NavigationView{
            List {
                ForEach(networkManager.launches, id: \.name) { launch in
                    NavigationLink(
                        destination: Text("Destination"),
                        label: {
                            LaunchRow(launch:launch)
                        })
                }
            }
            .listRowBackground(Color.astroUITableCell)
          //  .listSeparatorStyle(.singleLine, color: .astroUITableSeparator)
            .navigationTitle("Launches")
            .toolbar {
                ToolbarItem(placement: .automatic)
                {
                    Button(action: showSettings) {
                        Label("Settings", systemImage: "gear")
                    }
                }
            }
        }
        //#endif
        
       /* #if os(macOS)
        NavigationView{
        List {
            ForEach(networkManager.launches, id: \.name) { item in
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        Text(item.name)
                    })
            }
        }
        .listRowBackground(Color(NSColor.astroUITableCell))
        .navigationTitle("Launches")
        .toolbar {
            ToolbarItem(placement: .primaryAction)
            {
                Button(action: showSettings) {
                    Label("Settings", systemImage: "gear")
                }
            }
        }
        }

        #endif*/
    }

    private func showSettings() {
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchList().preferredColorScheme(.dark)
    }
}
