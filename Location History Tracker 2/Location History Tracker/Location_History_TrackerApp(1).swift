//
//  Location_History_TrackerApp.swift
//  Location History Tracker
//
//  Created by Eric Zhu on 09/10/1401 AP.
//

import SwiftUI
import CoreLocation


struct LocationPin: Codable, Identifiable{
    
    
    
    init(Long longitude: Double, Latt lattitude: Double) {
        long = longitude
        latt = lattitude
        date = Date()
    }
    
    let id = UUID()
    var long: Double
    var latt: Double
    var date: Date
}


func getSavedLocationPins() -> [LocationPin]? {
    let userDefaults = UserDefaults.standard
    var returnVal:[LocationPin]? = nil
    if let retreivedData = userDefaults.object(forKey: "locations") as? Data ?? nil {
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([LocationPin].self, from: retreivedData) {
            // print(decoded)
            
            returnVal = decoded
        }
        
    }
    return returnVal
}

func addToSavedLocation(toInput:LocationPin) -> Bool {
    var currentPins = getSavedLocationPins() ?? ([] as [LocationPin])
    let userDefaults = UserDefaults.standard
    currentPins.insert(toInput, at:0)
    // currentPins.append(toInput)
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(currentPins) {
        userDefaults.set(encoded, forKey: "locations")
        return true
    }
    return false
}

func clearHistory() -> Bool {
    let userDefaults = UserDefaults.standard
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode([] as [LocationPin]) {
        userDefaults.set(encoded, forKey: "locations")
        return true
    }
    return false
    
}

struct menuItem: Identifiable{
    let id = UUID()
    
    var day: Int
    var month: Int
    var year: Int
    var description: String
    var pins: [LocationPin]
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var manager = CLLocationManager()

    override init() {
        super.init()
        manager = CLLocationManager()
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.startMonitoringSignificantLocationChanges()
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            addToSavedLocation(toInput: LocationPin(Long: location.coordinate.longitude, Latt: location.coordinate.latitude))
        }
    }
}

@main
struct Location_History_TrackerApp: App {
    var menuItems:[menuItem] = []
    let manager = LocationManager()

    
    init() {
        // Load location pins
        var keys:[String] = []
        let locs = getSavedLocationPins() ?? []
        
        var ourDict:[String:menuItem] = [:]
        for val in locs {
            let components = Calendar.current.dateComponents([.year, .month, .day], from: val.date)
            // print(components)
            if let year = components.year, let month = components.month, let day = components.day {
                let key = String(year) + " " + String(month) + " " + String(day)
                let desc =  DateFormatter().monthSymbols[month - 1] + " \(day), \(year)"
                
                var retrieved = (ourDict[key] ?? menuItem(day: day, month: month, year: year, description: desc, pins: []))
                
                
                
                retrieved.pins.append(val)
                ourDict[key] = retrieved
                if (!keys.contains(key)) {
                    keys.append(key)
                }
            }
        }
        keys = keys.sorted(by: >)
        // print(ourDict)
        // print(keys)
        
        for key in keys {
            menuItems.append(ourDict[key]!)
        }
        print(menuItems)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(menuItems: menuItems)
        }
    }
}
