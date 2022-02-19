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
                .background(Color.launchesTagBackgroundColor)

                .background(RoundedRectangle(cornerRadius: 3.0, style: .continuous)
                .stroke(Color.launchesTagBorderColor, style: StrokeStyle(lineWidth: 1))
                .shadow(color: .launchesTagBorderColor, radius: 1, x:0, y: 0)
                .clipShape(RoundedRectangle(cornerRadius: 3.0, style: .continuous))
                )
    }
}


struct StatusTag: View {
    @State var text:String
    @State var status:AstroStatus
    @ScaledMetric(relativeTo: .caption) private var radius: CGFloat = 3
    @ScaledMetric(relativeTo: .caption) private var padding: CGFloat = 4
    @Environment(\.colorScheme) var colorScheme
    


    var body: some View {
        Text(text)
            .padding(.top,padding)
            .padding(.bottom,padding)
            .padding(.leading,padding*2)
            .padding(.trailing,padding*2)
            .font(.caption).foregroundColor(Color(.label))
            .background(RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .stroke(Color.colorForAstroStatus(status), style: StrokeStyle(lineWidth: 2))
                            .background(colorScheme == .light ? Color.colorForAstroStatus(status).opacity(0.1) : Color.colorForAstroStatus(status).opacity(0.1) )
                            .shadow(color:Color.colorForAstroStatus(status), radius: 1, x:0, y: 0)
                           //.clipShape(RoundedRectangle(cornerRadius: 3.0, style: .continuous))
            )
    }
}

struct TitleStatusTag: View {
    @State var text:String
    @State var status:AstroStatus
    private let font:Font = .largeTitle
    @ScaledMetric(relativeTo: .largeTitle) private var radius: CGFloat = 6
    @ScaledMetric(relativeTo: .largeTitle) private var padding: CGFloat = 8
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text(text)
            .padding(.top,padding)
            .padding(.bottom,padding)
            .padding(.leading,padding*2)
            .padding(.trailing,padding*2)
            .font(font).foregroundColor(Color(.label))
            .background(RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .stroke(Color.colorForAstroStatus(status), style: StrokeStyle(lineWidth: 2))
                            .background(colorScheme == .light ? Color.colorForAstroStatus(status).opacity(0.1) : Color.colorForAstroStatus(status).opacity(0.1) )
                            .shadow(color:Color.colorForAstroStatus(status), radius: 1
                                    , x:0, y: 0)
                        //   .clipShape(RoundedRectangle(cornerRadius: 3.0, style: .continuous))
            )
    }
}




struct Tag_Previews: PreviewProvider {
    static var previews: some View {
        Tag(text: "test")
    }
}
/*
 case Off
 case Standby
 case Normal
 case Caution
 case Serious
 case Critical
 */
struct StatusTag_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StatusTag(text: "Off", status:.Off)
            StatusTag(text: "Standby", status:.Standby)
            StatusTag(text: "Normal", status:.Normal)
            StatusTag(text: "Caution", status:.Caution)
            StatusTag(text: "Serious", status:.Serious)
            StatusTag(text: "Critical", status:.Critical)
        }.preferredColorScheme(.dark).previewInterfaceOrientation(.landscapeLeft)
        VStack {
            StatusTag(text: "Off", status:.Off)
            StatusTag(text: "Standby", status:.Standby)
            StatusTag(text: "Normal", status:.Normal)
            StatusTag(text: "Caution", status:.Caution)
            StatusTag(text: "Serious", status:.Serious)
            StatusTag(text: "Critical", status:.Critical)
        }.preferredColorScheme(.light).previewInterfaceOrientation(.landscapeLeft)

    }
}

struct TitleStatusTag_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            TitleStatusTag(text: "Off", status:.Off)
            TitleStatusTag(text: "Standby", status:.Standby)
            TitleStatusTag(text: "Normal", status:.Normal)
            TitleStatusTag(text: "Caution", status:.Caution)
            TitleStatusTag(text: "Serious", status:.Serious)
            TitleStatusTag(text: "Critical", status:.Critical)
        }.preferredColorScheme(.dark)
            //.environment(\.sizeCategory, .accessibilityLarge)
    }
}



