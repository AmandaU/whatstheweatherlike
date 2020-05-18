//
//  LocationManager.swift
//  WhatsTheWeatherLike
//
//  Created by Amanda Baret on 2020/05/16.
//  Copyright © 2020 Amanda Baret. All rights reserved.
//

import Foundation
import  CoreLocation


class LocationManager: NSObject, CLLocationManagerDelegate {
    
    weak var delegate: UserLocationDelegate?
    private var locationManager: CLLocationManager!
    private var userlocation:  Coordinate?
    
    static let Instance = LocationManager()
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func LocateUser(){
        locationManager.startUpdatingLocation()
    }
    
    // MARK: Location Implementation
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("location error is = \(error.localizedDescription)")
        locationManager.stopUpdatingLocation()
        delegate?.UserLocated(success: false)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        LocationManager.Instance.userlocation = Coordinate(latitude: Double(manager.location?.coordinate.latitude ?? 0), longitude: Double(manager.location?.coordinate.longitude ?? 0))
        delegate?.UserLocated(success: true)
    }
    
    var UserLocation: Coordinate {
        get {
            return self.userlocation ?? Coordinate(latitude: 0, longitude: 0)
        }
    }
    
}
