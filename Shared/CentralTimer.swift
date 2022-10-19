//
//  CentralTimer.swift
//  Astro Launches
//
//  Created by rocketjeff on 11/29/21.
//

import Foundation
import SwiftUI

// create a central timer shared by onscreen clocks and countdown timers so their ticks are synchronized
var centralTimer =  Timer.publish(every: 1, on: .main, in: .common).autoconnect()
