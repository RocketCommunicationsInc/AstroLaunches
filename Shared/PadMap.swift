//
//  PadMap.swift
//  Astro Launches
//
//  Created by rocketjeff on 10/12/21.
//

import SwiftUI
import MapKit

struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}

// Show a map extending 500 miles wide across, centered on the launch site coodiates
// Automatically update the region as the
struct PadMap: View {
    var coordinates:CLLocationCoordinate2D
    @State private var region:MKCoordinateRegion
    let fiveHundredMiles:Double = 804672 // meters
    
    init(coordinates :CLLocationCoordinate2D)
    {
        self.coordinates = coordinates
        region = MKCoordinateRegion(
            center: coordinates,
            latitudinalMeters: fiveHundredMiles,
            longitudinalMeters: fiveHundredMiles
        )
    }
    var body: some View {
        let place = IdentifiablePlace(lat: coordinates.latitude,long: coordinates.longitude)
        Map(coordinateRegion: $region, interactionModes: [],annotationItems: [place])
        { place in
            MapMarker(coordinate: place.location,   // put a marker at the launch site coordinates
                      tint: Color.astroUITint)
        }.focusable(false) // doesn't work, still gets focus if it's the only thing onscreen
        .onChange(of: coordinates) { newCoordinates in // on change of coordinates, update our related state variable 'region'
            region = MKCoordinateRegion(
                center: newCoordinates,
                latitudinalMeters: fiveHundredMiles,
                longitudinalMeters: fiveHundredMiles
            )
        }
        
    }
}

// extend CLLocationCoordinate2D to be Equatable so it can be checked in onChange
extension CLLocationCoordinate2D: Equatable {}

public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}


