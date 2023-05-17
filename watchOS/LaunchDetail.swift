//
//  LaunchDetail.swift
//  Astro Launches watchOS
//
//  Created by Jeff Hokit on 5/17/23.
//


import SwiftUI
import AstroSwiftFoundation
import CachedAsyncImage

struct LaunchDetail: View {
    var launch:Launch
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading,spacing:0){
                // Launch Image and Countdown clock
                LaunchDetailImage(launch: launch)
                
                //Calendar, Clock
                ViewThatFits{
                    HStack{
                        LaunchDate(launch: launch)
                        Spacer()
                        LaunchTime(launch: launch)
                    }.padding()
                    
                    VStack{
                        LaunchDate(launch: launch)
                        Spacer()
                        LaunchTime(launch: launch)
                    }.padding()
                }
                
                // Longer mission description
                MissionDescription(launch: launch)
                    .padding()
                
                // Mission status, as a title and tag
                MissionStatus(launch: launch)
                    .padding()
                
                // Rocket
                RocketName(launch:launch)
                    .padding()
                
                // Location
                Location(launch:launch)
                    .padding()
                
                // Map of the Launch Pad
                PadMap(coordinates:launch.locationCoordinate)
                    .frame(minHeight:100,idealHeight: 170)
                    .cornerRadius(6)
                    .padding()
            }
        }
        .navigationTitle(launch.missionName)
    }
}

struct LaunchDetailImage: View {
    var launch:Launch
    
    var body: some View {
        ZStack(alignment:.bottom){
            // Image or placehoder
            if let imageURL = launch.imageURL
            {
                CachedAsyncImage(url:imageURL , content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()

                }, placeholder: { // image still loading, use a simple rectangle fill + ProgressView
                    ZStack{
                        Rectangle()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                        ProgressView()
                    }
                })
            }
            else { // no image available, use a simple rectangle fill
                Rectangle()
                    .foregroundColor(.astroUIBackground)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            }
        }
    }
}

struct MissionDescription: View {
    var launch:Launch
    var body: some View {
        VStack(alignment: .leading){
            Text("MISSION").font(.headline).foregroundColor(.launchesTextColor)
            Spacer()
            Text(launch.missionDescription).font(.body)
        }
    }
}



struct LaunchAgency: View {
    var launch:Launch
    var body: some View {
        VStack(alignment: .leading){
            Text("AGENCY").font(.headline).foregroundColor(.launchesTextColor)
            Spacer()
            Text(launch.serviceProviderName).font(.body)
        }
    }
}



struct MissionStatus: View {
    var launch:Launch
    var body: some View {
        VStack(alignment: .leading) {
            Text("STATUS").font(.headline).foregroundColor(.launchesTextColor)

            if let status = launch.status
            {
                Tag(text: status,status: launch.astroStatus)
            }
        }
    }
}



struct RocketName: View {
    var launch:Launch
    var body: some View {
        VStack(alignment: .leading) {
            Text("ROCKET").font(.headline).foregroundColor(.launchesTextColor)
            Spacer()
            Text(launch.rocketName).font(.body)
        }
    }
}

struct Location: View {
    var launch:Launch
    var body: some View {
        VStack(alignment: .leading) {
            Text("LOCATION").font(.headline).foregroundColor(.launchesTextColor)
            Spacer()
            Text(launch.locationName).font(.body)
        }
    }
}


struct LaunchDetail_Previews: PreviewProvider {
    static var networkManager = NetworkManager()

    static var previews: some View {
        LaunchDetail(launch:networkManager.upcomingLaunches[0])
            .preferredColorScheme(.dark)
    }
}
