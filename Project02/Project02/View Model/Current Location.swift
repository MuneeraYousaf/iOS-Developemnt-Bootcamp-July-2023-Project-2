//
//  Current Location.swift
//  Project02
//
//  Created by Muneera Y on 03/02/1445 AH.
//
import CoreLocation
import CoreLocationUI
import Foundation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle the error here
        print("Location manager failed with error: \(error.localizedDescription)")
        
        // You can add more error handling logic here, such as displaying an alert to the user
    }
}
