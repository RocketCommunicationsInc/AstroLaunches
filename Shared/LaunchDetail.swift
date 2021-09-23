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
                    if let image = launch.image
                    {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: 10, idealHeight: 400, maxHeight: 400, alignment: .center)
                            .clipped()
                    }
                    else
                    {
                        Image("launch")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 10, idealWidth: .infinity, maxWidth: .infinity, minHeight: 10, idealHeight: 400, maxHeight: 400, alignment: .center)
                            .clipped()
                    }
                    CountdownPip(launch: launch)
                        .padding(.all, 8.00)
                        .background(.ultraThinMaterial)

                }
                HStack {
                    Text(launch.name).font(.title3).bold()
                    Spacer()
                }.padding(.vertical, 4)
                HStack{
                    CalendarPip(launch: launch)
                    Spacer()
                    ClockPip(launch: launch)
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
                .font(.caption).foregroundColor(.launchesTextColor)
                .background(RoundedRectangle(cornerRadius: 3.0, style: .continuous)
                                .stroke(Color.launchesTagBorderColor, style: StrokeStyle(lineWidth: 1))
                                .background(Color.launchesTagBackgroundColor)
                )
               
    }
}
