//
//  Launch.swift
//  Astro Launches
//
//  Created by rocketjeff on 3/29/21.
//

import Foundation

struct Launch:Decodable{
    let name:String
    let date_str:String
    let t0:String?
    let weather_temp:Float?
    let weather_icon:String?
    let win_open:String?
}
