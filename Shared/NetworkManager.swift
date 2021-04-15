//
//  NetworkManager.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/17/21.
//

import Foundation

private struct LaunchReplies:Decodable{
    let count:Int
    let result:[LaunchReply]
}


struct LaunchReply:Decodable{
    let name:String
    let date_str:String
    let t0:String?
    let weather_temp:Float?
    let weather_icon:String?
    let win_open:String?
    let win_close:String?
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
            myLaunches.result.forEach() { launchJSON in
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
            url = URL(string: "https://fdo.rocketlaunch.live/json/launches?key=8ce4c428-bb89-4c5f-953c-1ba70eab26fa")
        }
        
        if let url = url
        {
        URLSession.shared.dataTask(with: url) { (data,_ , _) in
            guard let data = data else {return}
            let myLaunches = try! JSONDecoder().decode(LaunchReplies.self, from: data)
            DispatchQueue.main.async {
               // self.launchJSONs = myLaunches.result
                
                // post process launchJSONs into launches
                myLaunches.result.forEach() { launchJSON in
                    self.launches.append(Launch(launchJSON))
                }

//              print(myLaunches)
            }
        }.resume()
        }
    }
}
