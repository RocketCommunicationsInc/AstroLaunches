//
//  Tag.swift
//  Astro Launches (iOS)
//
//  Created by rocketjeff on 9/30/21.
//

import SwiftUI
import AstroSwiftFoundation

struct Tag: View {
    var text:String
    var body: some View {
            Text(text)
                .padding(4.0)
                .font(.caption).foregroundColor(.launchesTextColor)
                .background(RoundedRectangle(cornerRadius: 3.0, style: .continuous)
                                .stroke(Color.launchesTagBorderColor, style: StrokeStyle(lineWidth: 1))
                                .background(Color.launchesTagBackgroundColor)
                                .shadow(color: .launchesTagBorderColor, radius: 1, x:0, y: 0)
                                .clipShape(RoundedRectangle(cornerRadius: 3.0, style: .continuous)
)
                )
    }
}


struct StatusTag: View {
    var text:String
    var status:AstroStatus
    var body: some View {
            Text(text)
                .padding(4.0)
                .font(.caption).foregroundColor(.black)
                .background(RoundedRectangle(cornerRadius: 3.0, style: .continuous)
                                .stroke(Color.borderColorForAstroStatus(status), style: StrokeStyle(lineWidth: 1))
                                .background(Color.colorForAstroStatus(status))
                                .shadow(color:Color.borderColorForAstroStatus(status), radius: 1, x:0, y: 0)
                                .clipShape(RoundedRectangle(cornerRadius: 3.0, style: .continuous)
)
                )
    }
}

struct GiantStatusTag: View {
    var text:String
    var status:AstroStatus
    var body: some View {
            Text(text)
            .padding(.all,25.0)
                .font(.system(size: 60)).foregroundColor(.black)
                .background(RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                                .stroke(Color.borderColorForAstroStatus(status), style: StrokeStyle(lineWidth: 10))
                                .background(Color.colorForAstroStatus(status))
                                .shadow(color:Color.borderColorForAstroStatus(status), radius: 10, x:0, y: 0)
                                .clipShape(RoundedRectangle(cornerRadius: 12.0, style: .continuous)
)
                )
    }
}

struct Tag_Previews: PreviewProvider {
    static var previews: some View {
        Tag(text: "test")
    }
}


struct StatusTag_Previews: PreviewProvider {
    static var previews: some View {
        StatusTag(text: "test", status:.Normal)
    }
}

struct GiantStatusTag_Previews: PreviewProvider {
    static var previews: some View {
        GiantStatusTag(text: "test", status:.Normal)
    }
}


