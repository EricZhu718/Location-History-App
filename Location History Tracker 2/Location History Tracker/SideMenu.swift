//
//  SideMenu.swift
//  Location History Tracker
//
//  Created by Eric Zhu on 15/10/1401 AP.
//

import Foundation
import SwiftUI
import MapKit


struct SideMenuView: View {
    @Binding var menuOpen: Bool
    
    let items:[LocationPin]
    init(menuOpen: Binding<Bool>) {
        items = getSavedLocationPins() ?? []
        self._menuOpen = menuOpen
    }
    
    var body: some View {
        List(items) {
            item in Button(
                action: {
                    withAnimation {
                        menuOpen.toggle()
                    }
                }, label: {
                    
                    Text("\(item.date): (\(item.latt), \(item.long))")
                }
            )
        }.transition(.move(edge: .leading))
        
    }
}


