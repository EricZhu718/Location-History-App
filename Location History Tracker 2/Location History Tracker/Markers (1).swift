//
//  Markers.swift
//  Location History Tracker
//
//  Created by Eric Zhu on 11/10/1401 AP.
//

import Foundation
import SwiftUI
import MapKit


struct MarkerView: View {
    @State private var region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 40.83834587046632,
                    longitude: 14.254053016537693),
                span: MKCoordinateSpan(
                    latitudeDelta: 1.0,
                    longitudeDelta: 1.0)
                )
    var body: some View {
        VStack{
            Text("Goodbye World")
            Map(coordinateRegion: $region)
                .edgesIgnoringSafeArea(.all)
        }
    }
}


struct MarkerView_Previews: PreviewProvider {
    static var previews: some View {
        MarkerView()
    }
}
