//
//  NetworkManager.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/17/21.
//

import Foundation



private struct LaunchReplies:Decodable{
    //let count:Int
    let results:[LaunchReply]
}


class NetworkManager:ObservableObject
{
    private var launchJSONs = [LaunchReply]()
    @Published var launches = [Launch]()

    init(){
        var url:URL?
        let runningInPreview = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"]
        if (runningInPreview == "1")
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
        
        if (Settings.localData)
        {
            let path = Bundle.main.path(forResource: "launches", ofType: "json")!
            url = URL(fileURLWithPath: path)
        }
        else
        {
            url = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/upcoming/?limit=10&mode=list")
        }
        
        if let url = url
        {
        URLSession.shared.dataTask(with: url) { (data,_ , _) in
            guard let data = data else {return}
            let myLaunches = try! JSONDecoder().decode(LaunchReplies.self, from: data)
            DispatchQueue.main.async {
               // self.launchJSONs = myLaunches.result
                
                // post process launchJSONs into launches
                myLaunches.results.forEach() { launchJSON in
                    self.launches.append(Launch(launchJSON))
                }

//              print(myLaunches)
            }
        }.resume()
        }
    }
}
