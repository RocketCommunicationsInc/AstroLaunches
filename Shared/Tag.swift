//
//  Tag.swift
//  Astro Launches (iOS)
//
//  Created by rocketjeff on 9/30/21.
//

import SwiftUI
import AstroSwiftFoundation


// A tag using standard Astro Colors. Uses the .caption font.
// Scales in response to accessibility settings.
struct Tag: View {
    var text:String
    private let font:Font = .caption
    @ScaledMetric(relativeTo: .caption) private var radius: CGFloat = 3
    @ScaledMetric(relativeTo: .caption) private var padding: CGFloat = 4
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Text(text)
            .padding(.top,padding)
            .padding(.bottom,padding)
            .padding(.leading,padding*2)
            .padding(.trailing,padding*2)
            .font(font).foregroundColor(Color(.label))
            .background(RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .stroke(Color.launchesTagBorderColor, style: StrokeStyle(lineWidth: 1))
                            .background(colorScheme == .light ? Color.launchesTagBackgroundColor : Color.launchesTagBorderColor.opacity(0.1) )
                            .shadow(color:Color.launchesTagBorderColor, radius: 1, x:0, y: 0)
            )
    }
}

// A tag using Astro Status Colors and Status Symbols. Uses the .caption font.
// Scales in response to accessibility settings.
struct StatusTag: View {
    var text:String
    var status:AstroStatus
    private let font:Font = .caption
    @ScaledMetric(relativeTo: .caption) private var radius: CGFloat = 3
    @ScaledMetric(relativeTo: .caption) private var padding: CGFloat = 4
    @ScaledMetric(relativeTo: .caption) private var scale: CGFloat = 1
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack(spacing:0){
            Image(uiImage: UIImage.imageForAstroStatus(status))
            .resizable()
            .frame(width: 10 * scale, height: 10 * scale)
            .padding(.leading,padding*2)
            .padding(.trailing,padding/2)
        Text(text)
            .padding(.top,padding)
            .padding(.bottom,padding)
            .padding(.leading,padding/2)
            .padding(.trailing,padding*2)
            .font(font).foregroundColor(Color(.label))
        }
        .background(RoundedRectangle(cornerRadius: radius, style: .continuous)
        .stroke(Color.colorForAstroStatus(status), style: StrokeStyle(lineWidth: 1))
                        .background(colorScheme == .light ? Color.color200ForAstroStatus(status) : Color.colorForAstroStatus(status).opacity(0.1) )
                        .shadow(color:Color.colorForAstroStatus(status), radius: 1, x:0, y: 0))

    }
}

// A large tag using Astro Status Colors, suitable for tvOS
// Scales in response to accessibility settings.
struct TitleStatusTag: View {
    var text:String
    var status:AstroStatus
    private let font:Font = .largeTitle
    @ScaledMetric(relativeTo: .largeTitle) private var radius: CGFloat = 6
    @ScaledMetric(relativeTo: .largeTitle) private var padding: CGFloat = 8
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text(text)
            .fontWeight(Font.Weight.semibold)
            .padding(.top,padding)
            .padding(.bottom,padding)
            .padding(.leading,padding*2)
            .padding(.trailing,padding*2)
            .font(font).foregroundColor(Color(.label))
            .background(RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .stroke(Color.colorForAstroStatus(status), style: StrokeStyle(lineWidth: 2))
                            .background(colorScheme == .light ? Color.color200ForAstroStatus(status) : Color.colorForAstroStatus(status).opacity(0.1) )
                            .shadow(color:Color.colorForAstroStatus(status), radius: 1, x:0, y: 0)
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
        VStack {
            Tag(text: "Astro")
            StatusTag(text: "Off", status:.Off)
            StatusTag(text: "Standby", status:.Standby)
            StatusTag(text: "Normal", status:.Normal)
            StatusTag(text: "Caution", status:.Caution)
            StatusTag(text: "Serious", status:.Serious).environment(\.sizeCategory, .accessibilityLarge)
            StatusTag(text: "Critical", status:.Critical)
        }.preferredColorScheme(.dark).previewInterfaceOrientation(.landscapeLeft)
        VStack {
            Tag(text: "Astro")
            StatusTag(text: "Off", status:.Off)
            StatusTag(text: "Standby", status:.Standby)
            StatusTag(text: "Normal", status:.Normal)
            StatusTag(text: "Caution", status:.Caution)
            StatusTag(text: "Serious", status:.Serious).environment(\.sizeCategory, .accessibilityLarge)
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
    }
}



