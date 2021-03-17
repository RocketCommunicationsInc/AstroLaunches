//
//  ContentView.swift
//  Shared
//
//  Created by rocketjeff on 1/12/21.
//

import SwiftUI
import CoreData
import AstroSwiftFoundation
import SwiftUIListSeparator
//import Combine


struct ContentView: View {
    
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
        
        #if os(iOS)
        // must embed List within a NavigationView on iOS or .toolbar wont work
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
            .listRowBackground(Color(UIColor.astroUITableCell))
            .listSeparatorStyle(.singleLine, color: .astroUITableSeparator)
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
        #endif
        
        #if os(macOS)
        List {
            let launchArray =
            [
                Launch.init(name: "Launch 1"),
                Launch.init(name: "Launch 2")
            ]
            ForEach(launchArray, id: \.name) { item in
                Text(item.name)
            }
            .listRowBackground(Color(UIColor.astroUITableCell))
        }.toolbar {
            Button(action: addItem) {
                Label("Add Item", systemImage: "gear")
            }
        }
        #endif
    }

    private func showSettings() {
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
