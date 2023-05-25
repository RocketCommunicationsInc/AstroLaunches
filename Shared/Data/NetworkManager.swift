//
//  NetworkManager.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/17/21.
//

import Foundation
import SwiftUI
import AstroSwiftUtilities


// The API lets us choose upcoming or recent launches
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

// NetworkManager handles the data connection and initiates the parsing of the results into an array of Launch objects
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
    
    // Data Caches stored in user defaults
    @AppStorage("UpcomingDataCache") var upcomingDataCache:Data = Data()
    @AppStorage("UpcomingDataCacheDate") var upcomingDataCacheDate:Date = Date.distantPast
    @AppStorage("RecentDataCache") var recentDataCache:Data = Data()
    @AppStorage("RecentDataCacheDate") var recentDataCacheDate:Date = Date.distantPast
    let twelveHours:TimeInterval = 12 * 60 * 60 // TimeInterval unit is seconds

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
    
    // Load launches for timePeriod, from cache or network
    // Convert into an array of Launch objects
    func loadLaunches(_ timePeriod:TimePeriod) async
    {
        // if the cached data is usable process that data, otherwise download new data
        if cacheIsUsable(timePeriod) {
            loadFromCache(timePeriod)
        }
        else {
            await loadFromNetwork(timePeriod)
        }
    }

    // return true if the cache for timePeriod is less than twelve hours old, and there is some data in the cache
    func cacheIsUsable(_ timePeriod:TimePeriod)->Bool {
        
        let cacheAge = timePeriod == .upcoming ? Date().timeIntervalSince(upcomingDataCacheDate) :  Date().timeIntervalSince(recentDataCacheDate)
        
        let cacheSize = timePeriod == .upcoming ? upcomingDataCache.count : recentDataCache.count
        
        return cacheAge < twelveHours && cacheSize > 1
    }
    
    // load from cached data for timePeriod
    func loadFromCache(_ timePeriod:TimePeriod) {
        print("good cache found")
        let data = timePeriod == .upcoming ? upcomingDataCache : recentDataCache
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
    
    // load from thespacedevs.com
    func loadFromNetwork(_ timePeriod:TimePeriod) async {
        do {
            var timeframeParam:String = timePeriod == .upcoming ? "upcoming" : "previous"
            // If building for debug, use the lldev URL, as requested by the provider, possibly stale data
#if DEBUG
            let url = URL(string: "https://lldev.thespacedevs.com/2.2.0/launch/\(timeframeParam)/?limit=10&mode=detailed")
            // If building for release, use the real URL. Get 10 launches
#else
            let url = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/\(timeframeParam)/?limit=10&mode=detailed")
#endif
            // make the HTTP request, parse the response
            let (data, response) = try await URLSession.shared.data(from: url!)
            let urlResponse = response as! HTTPURLResponse
            let status = urlResponse.statusCode
            guard (200...299).contains(status) else {
                if (status == 429) {
                    // handle "Too Many Requests" error
                    self.prepareAlert(title: "Too Many Requests", message: HTTPURLResponse.localizedString(forStatusCode: status))
                }
                else {
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
                // if the cache is old, write fresh data to cache on the main thread as required for @AppStorage
                if !cacheIsUsable(timePeriod) {
                    if timePeriod == .upcoming {
                        upcomingDataCache = data
                        upcomingDataCacheDate = Date()
                        print("writing to upcoming cache")
                    }
                    else {
                        recentDataCache = data
                        recentDataCacheDate = Date()
                        print("writing to recent cache")
                    }
                }
                
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
