//
//  PlayPauseHUD.swift
//  Astro Launches (tvOS)
//
//  Created by Jeff Hokit on 10/28/22.
//

import SwiftUI

struct PlayPauseHUD: View {
    @AppStorage(appStorageAdvanceModeKey) var advanceMode:AdvanceMode = .automatic // default to automatic

    var body: some View {
        VStack{
            Image(systemName: advanceMode == .automatic ? "play" : "pause")
            Text( advanceMode == .automatic ? "Playing" : "Paused")
        }
        .font(.largeTitle)
        .padding(40)
        .background(RoundedRectangle(cornerRadius: 20).fill(.regularMaterial))
    }
}

struct PlayPauseHUD_Previews: PreviewProvider {
    static var previews: some View {
        PlayPauseHUD()
    }
}
