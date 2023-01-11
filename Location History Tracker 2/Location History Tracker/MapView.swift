//
//  MapView.swift
//  Location History Tracker
//
//  Created by Eric Zhu on 15/10/1401 AP.
//

import SwiftUI
import MapKit


struct MapView: View {
    @State var region  = MKCoordinateRegion(
        center:
            CLLocationCoordinate2D(
                latitude: 38.907192,
                longitude: -77.036873),
        span:
            MKCoordinateSpan(
                latitudeDelta: 0.4,
                longitudeDelta: 0.4)
    )

    
    var body: some View {
        Map(coordinateRegion: $region)
        .edgesIgnoringSafeArea(.all)
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
