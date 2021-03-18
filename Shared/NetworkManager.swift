//
//  NetworkManager.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/17/21.
//

import Foundation

struct LaunchReply:Decodable{
    let count:Int
    let result:[Launch]
}

struct Launch:Decodable{
    let name:String
}

class NetworkManager:ObservableObject
{
    @Published var launches = [Launch]()
        
    init(){
        guard let url = URL(string: "https://fdo.rocketlaunch.live/json/launches?key=8ce4c428-bb89-4c5f-953c-1ba70eab26fa") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data,_ , _) in
            guard let data = data else {return}
            let myLaunches = try! JSONDecoder().decode(LaunchReply.self, from: data)
            DispatchQueue.main.async {
                self.launches = myLaunches.result
//                print(myLaunches)
//                print("hello world")
            }
        }.resume()
    }
}
