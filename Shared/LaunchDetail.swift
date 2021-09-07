//
//  LaunchDetail.swift
//  Astro Launches
//
//  Created by rocketjeff on 9/7/21.
//

import SwiftUI

struct LaunchDetail: View {
    var launch:Launch
    var body: some View {
        Text(launch.name)
    }
}

struct LaunchDetail_Previews: PreviewProvider {
    static var networkManager = NetworkManager()

    static var previews: some View {
        LaunchDetail(launch:networkManager.launches[0])
    }
}
