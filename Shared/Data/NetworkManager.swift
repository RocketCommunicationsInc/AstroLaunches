//
//  NetworkManager.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/17/21.
//

import Foundation
import SwiftUI
import AstroSwiftUtilities

// NetworkManager handles the data connection and initiates the parsing of the results into an array of *Launch* objects

enum TimePeriod:Int {
    case upcoming
    case recent
    
    func name()->String{
        return self == .upcoming ? "Upcoming" : "Recent"
    }
}


private struct LaunchReplies:Decodable{
    let results:[LaunchReply]
}

class NetworkManager:ObservableObject
{
    // the main observable lists of launch objects, upcoming and past
    @Published var upcomingLaunches = [Launch]()
    @Published var pastLaunches = [Launch]()
    
    // stored when encountering a network error
    @Published var statusCode:Int?
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var isShowingNetworkAlert = false
        
    @AppStorage("DataCache") var dataCache:String = ""
    @AppStorage("DataCacheDate") var dataCacheDate:Date = Date.distantPast

    // Let observers know that an error has occured.
    // Do nothing if a previous error has not been acknowledged by setting isShowingNetworkAlert to false
    func prepareAlert(title:String, message:String)
    {
        Task { @MainActor in // post the alert from the main thread
            if self.isShowingNetworkAlert {return}
            self.alertTitle = title
            self.alertMessage = message
            self.isShowingNetworkAlert = true
        }
    }
    
    init(timePeriods:[TimePeriod]){
        // load chosen TimePeriods
        Task{
            if timePeriods.contains(.upcoming)
            {
                await loadLaunches(TimePeriod.upcoming)
            }
            if timePeriods.contains(.recent)
            {
                await loadLaunches(TimePeriod.recent)
            }
        }
    }
    
    
    func loadLaunches(_ timePeriod:TimePeriod) async
    {
        var url:URL?
        var timeframeParam:String = timePeriod == .upcoming ? "upcoming" : "previous"
        
        // If building for debug, use the lldev URL, as requested by the provider, possibly stale data
        #if DEBUG
        url = URL(string: "https://lldev.thespacedevs.com/2.2.0/launch/\(timeframeParam)/?limit=10&mode=detailed")
        // If building for release, use the real URL. Get 10 launches
        #else
        url = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/\(timeframeParam)/?limit=10&mode=detailed")
        #endif
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url!)
            let urlResponse = response as! HTTPURLResponse
            let status = urlResponse.statusCode
            guard (200...299).contains(status) else {
                if (status == 429)
                {
                    // handle "Too Many Requests" error
                    self.prepareAlert(title: "Too Many Requests", message: HTTPURLResponse.localizedString(forStatusCode: status))
                }
                else
                {
                    // handle generic error
                    self.prepareAlert(title: "Server Error", message: HTTPURLResponse.localizedString(forStatusCode: status))
                }
                return
            }

            guard !data.isEmpty else {
                // handle zero data error
                self.prepareAlert(title: "No Data Returned", message: HTTPURLResponse.localizedString(forStatusCode: status))
                return
            }
            
            let myLaunches = try! JSONDecoder().decode(LaunchReplies.self, from: data)
            Task { @MainActor in
                // post process launchJSONs into launches on the main thread, as this will trigger UI updates
                myLaunches.results.forEach() { launchJSON in
                    if (timePeriod == .upcoming) {
                        self.upcomingLaunches.append(Launch(launchJSON))
                    }
                    else {
                        self.pastLaunches.append(Launch(launchJSON))
                    }
                }
            }
        }
        catch {
            self.prepareAlert(title: "Network Error", message: error.localizedDescription)
            return
        }
    }
}
