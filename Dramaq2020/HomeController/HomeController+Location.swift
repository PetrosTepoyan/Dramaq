//
//  HomeController+Location.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 9/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation
import CoreLocation

extension HomeController: CLLocationManagerDelegate {
    
    
    
    func setupLoc() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation

        latitude = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}
