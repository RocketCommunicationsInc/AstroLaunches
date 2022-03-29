//
//  NetworkManager.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/17/21.
//

import Foundation

// NetworkManager handles the data connection and initiates the parsing of the results into an array of *Launch* objects


private struct LaunchReplies:Decodable{
    //let count:Int
    let results:[LaunchReply]
}

class NetworkManager:ObservableObject
{
    private var launchJSONs = [LaunchReply]()
    @Published var launches = [Launch]()
    @Published var transportError:Error?
    @Published var statusCode:Int?
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var isShowingNetworkAlert = false
    
    func prepareAlert(title:String, message:String)
    {
        DispatchQueue.main.async {
            if self.isShowingNetworkAlert {return}
            self.alertTitle = title
            self.alertMessage = message
            self.isShowingNetworkAlert = true
        }
    }
    
    init(){
        var url:URL?
        let runningInPreview = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"]
        if (runningInPreview == "1") // if in the SwiftUI Canvas, always load stored test data
        {
            let path = Bundle.main.path(forResource: "launches", ofType: "json")!
            url = URL(fileURLWithPath: path)
            let data = NSData(contentsOf: url!)
            let myLaunches = try! JSONDecoder().decode(LaunchReplies.self, from: data! as Data)
            myLaunches.results.forEach() { launchJSON in
                self.launches.append(Launch(launchJSON))
            }
            return
        }
        
        if (Settings.localData) // if the user setting to use stored data is on, load stored test data
        {
            let path = Bundle.main.path(forResource: "launches", ofType: "json")!
            url = URL(fileURLWithPath: path)
        }
        else
        {
            // If building for debug, use the lldev URL, as requested by the provider, possibly stale data
            #if DEBUG
            url = URL(string: "https://lldev.thespacedevs.com/2.2.0/launch/upcoming/?limit=10&mode=detailed&format=json")
            // If building for release, use the real URL. Get 10 launches
            #else
            url = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/upcoming/?limit=10&mode=detailed")
            #endif
        }
        
        if let url = url
        {
            URLSession.shared.dataTask(with: url) { data, urlResponse, error in
                if let myError = error {
                    self.prepareAlert(title: "Network Error", message: myError.localizedDescription)
                    return
                }
                
                let response = urlResponse as! HTTPURLResponse
                let status = response.statusCode
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

                guard let data = data else {
                    // handle zero data error
                    return
                }
                
                let myLaunches = try! JSONDecoder().decode(LaunchReplies.self, from: data)
                DispatchQueue.main.async {
                    // post process launchJSONs into launches
                    myLaunches.results.forEach() { launchJSON in
                        self.launches.append(Launch(launchJSON))
                    }
                }
            }.resume()
        }
    }
}
