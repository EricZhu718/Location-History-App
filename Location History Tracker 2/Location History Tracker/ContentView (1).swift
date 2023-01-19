//
//  ContentView.swift
//  Location History Tracker
//
//  Created by Eric Zhu on 09/10/1401 AP.
//

import SwiftUI
import MapKit




struct ContentView: View {
    @State var menuOpen = false
    
    @State var items:[menuItem] = getMenuItems()
    @State var droppedPins:[LocationPin] = []
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
    
    @Environment(\.colorScheme) var colorScheme
    
    init() {
        // Load location pins
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Map(coordinateRegion: $region , showsUserLocation: true, annotationItems: droppedPins) {location in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latt, longitude: location.long))
                }
                .edgesIgnoringSafeArea(.all)
                .overlay {
                    VStack {
                        Spacer().frame(height:25)
                        HStack {
                            Button(
                                action: {
                                    withAnimation {
                                        menuOpen.toggle()
                                    }
                                }, label: {
                                    Text("Select Day")  .foregroundColor(.black)
                                
                            })
                                .padding()
                                .background(Color(red: 1, green: 1, blue: 1))
                                .clipShape(Capsule())
                            Spacer().frame(width: 250)
                            Text("")
                        }
                        // Spacer().frame(height: 10)
                        Spacer()
                        .background(colorScheme == .dark ? .black : .white)                    }
                }.onTapGesture {
                    menuOpen = false
                }
                if (menuOpen) {
                    
                    if (items.count == 0) {
                        VStack {
                            Text("No Previous Locations Available").transition(.move(edge: .leading)).frame(width: geometry.size.width/3*2)
                            Spacer().background(colorScheme == .dark ? .black : .white)
                            
                        }
                            .frame(width: geometry.size.width/3*2)
                            .background(colorScheme == .dark ? .black : .white)
                            .transition(.move(edge: .leading))
                        
                    } else {
                        VStack{
                            Text("Select Locations from History:").frame(width: geometry.size.width/3*2)
                                .background(colorScheme == .dark ? .black : .white)
                            List(items) {
                                item in Button(
                                    action: {
                                        withAnimation {
                                            menuOpen.toggle()
                                            region.center = CLLocationCoordinate2D(
                                                latitude: item.pins.last!.latt,
                                                longitude: item.pins.last!.long
                                            )
                                            droppedPins = item.pins
                                        }
                                    }, label: {
                                        
                                        Text("\(item.description)")
                                    }
                                )
                            }
                        }.frame(width: geometry.size.width/3*2)
                            .background(colorScheme == .dark ? .black : .white)
                            .transition(.move(edge: .leading))
                    }
                }
            }
        }
    }
}

