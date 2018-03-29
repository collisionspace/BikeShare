//
//  LocationServices.swift
//  BikeShare
//
//  Created by SLONE, Daniel on 3/29/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationChangeDelegate: class {
    func locationChange(location: CLLocation)
}
protocol LocationServicesEnabledDelegate: class {
    func isLocationServicesEnabled(result: LocationServicesResult)
}
public enum LocationServicesResult: String {
    case noAccess
    case access
    case notEnabled
    case failed
}
class LocationServices: NSObject {
    static let shared = LocationServices()
    private let locationManager = CLLocationManager()
    
    weak var delegate: LocationChangeDelegate?
    weak var locationServicesEnabledDelegate:LocationServicesEnabledDelegate?
    var location:CLLocation?
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 5

        locationManager.activityType = .fitness
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationServices()
    }
    
    private func locationServices() {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                print("No access")
                locationServicesEnabledDelegate?.isLocationServicesEnabled(result: LocationServicesResult.noAccess)
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                locationServicesEnabledDelegate?.isLocationServicesEnabled(result: LocationServicesResult.access)
            }
        } else {
            print("Location services are not enabled")
            locationServicesEnabledDelegate?.isLocationServicesEnabled(result: LocationServicesResult.notEnabled)
        }
    }
}
extension LocationServices: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location
            delegate?.locationChange(location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
