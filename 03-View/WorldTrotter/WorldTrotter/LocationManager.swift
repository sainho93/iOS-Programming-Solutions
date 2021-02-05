//
//  Location.swift
//  WorldTrotter
//
//  Created by sainho on 02.02.21.
//  Copyright © 2021 Big Nerd Ranch. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: CLLocationManager, CLLocationManagerDelegate {
    // Set Class as Singleton
    static let sharedInstance = LocationManager()

    var locationManager: CLLocationManager! = CLLocationManager() // Always lives in app's life cycle
    
    // Avoid initiating
    private override init() {
        super.init()
        
        self.locationManager.delegate = self
    }
    
    func checkLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() == false ||
            self.locationManager.authorizationStatus != .authorizedWhenInUse {
            self.locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        let status = self.locationManager.authorizationStatus

        // Handle each case of location permissions
        switch status {
            case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
            case .restricted:
                self.locationManager.requestWhenInUseAuthorization()
            case .denied:
                self.locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways:
                break
            case .authorizedWhenInUse:
                break
            
        @unknown default:
            // <#fatalError()#>
            break
        }
    
    }
}
