//
//  PermissionManager.swift
//  FoodHere
//
//  Created by O GabrielPro on 11/06/23.
//

import CoreLocation

class PermissionManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var locationPermissionGranted = false
    
    override init() {
        super.init()
        
        locationManager.delegate = self
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func checkLocationPermission() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        locationPermissionGranted = authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationPermission()
    }
}


