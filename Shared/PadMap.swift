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

struct PadMap: View {
    var coord:CLLocationCoordinate2D
    @State private var region:MKCoordinateRegion
    
    init(coord :CLLocationCoordinate2D)
    {
        self.coord = coord
        region = MKCoordinateRegion(
            center: coord,
            latitudinalMeters: 880233,
            longitudinalMeters: 880233
        )
    }
    var body: some View {
        let place = IdentifiablePlace(lat:self.coord.latitude,long:self.coord.longitude)
        Group{

            Map(coordinateRegion: $region, interactionModes: [],annotationItems: [place])
            { place in
                MapMarker(coordinate: place.location,
                          tint: Color.astroUITint)
            }
        }.onChange(of: coord) { newCoord in
            region = MKCoordinateRegion(
                center: newCoord,
                latitudinalMeters: 880233,
                longitudinalMeters: 880233
            )
        }
        
    }
}

// extend CLLocationCoordinate2D to be Equatable so it can be checked in onChange
extension CLLocationCoordinate2D: Equatable {}

public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}


