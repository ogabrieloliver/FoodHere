//
//  CardStackViewController.swift
//  FoodHere
//
//  Created by O GabrielPro on 11/06/23.
//

import Foundation
import CoreLocation

class CardStackViewModel: ObservableObject {
    @Published var businesses: [Business] = []
    private let locationManager = CLLocationManager()
    private let yelpAPIKey = "itoMaM6DJBtqD54BHSZQY9WdWR5xI_CnpZdxa3SG5i7N0M37VK1HklDDF4ifYh8SI-P2kI_mRj5KRSF4_FhTUAkEw322L8L8RY6bF1UB8jFx3TOR0-wW6Tk0KftNXXYx"
    
    func loadBusinesses() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    private func fetchBusinesses(with coordinate: CLLocationCoordinate2D) {
        let url = URL(string: "https://api.yelp.com/v3/businesses/search")!
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: "\(coordinate.latitude)"),
            URLQueryItem(name: "longitude", value: "\(coordinate.longitude)"),
            URLQueryItem(name: "term", value: "restaurant")
        ]
        
        guard let finalURL = urlComponents?.url else {
            return
        }
        
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.addValue("Bearer \(yelpAPIKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(YelpAPIResponse.self, from: data)
                self.businesses = result.businesses
            } catch {
                print("Failed to decode Yelp API response: \(error)")
            }
        }.resume()
    }
}

extension CardStackViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        fetchBusinesses(with: location.coordinate)
        locationManager.stopUpdatingLocation()
    }
}


