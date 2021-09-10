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
        ScrollView(.vertical) {
            VStack(){
                // Launch Image and Countdown clock
                ZStack(alignment:.bottomTrailing){
                    Image("launch").resizable().frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: 10, idealHeight: 200, maxHeight: 200, alignment: .center)
                    CountdownPip(launch: launch)
                }
                HStack {
                    Text(launch.name).font(.title2).bold()
                    Spacer()
                }.padding(.vertical, 4)
                ZStack{
                    ClockPip(launch: launch) // a trick to center it in the HStack below: add in a zStack where it is naturally centered
                    HStack (){
                        CalendarPip(launch: launch)
                        Spacer()
                        WeatherPip(launch: launch)
                    }
                }.padding(.vertical, 4)
                HStack {
                    Text("Mission").font(.title3)
                    Spacer()
                }
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque id pellentesque neque. Nulla aliquam magna eu dictum dictum.").font(.body)
                HStack{
                    Tag(text: "Astro Commercial Crew Program")
                    Tag(text: "ISS Expedition")
                    Tag(text: "Crewed")
                }
                Spacer()
            }//.background(Color.astroUIBackground)
        }.padding()
        .background(Color.astroUIBackground)
    }
}

struct LaunchDetail_Previews: PreviewProvider {
    static var networkManager = NetworkManager()

    static var previews: some View {
        LaunchDetail(launch:networkManager.launches[0])
            .preferredColorScheme(.dark)
    }
}

struct Tag: View {
    var text:String
    var body: some View {
            Text(text)
                .padding(4.0)
                .font(.body).foregroundColor(.secondary)
                //.border(Color.blue, width: 2)
                .background(Capsule(style: .continuous)
                                .stroke(Color.astroUITint, style: StrokeStyle(lineWidth: 2)))

    }
}