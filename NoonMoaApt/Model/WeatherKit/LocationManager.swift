//
//  LocationManager.swift
//  NoonMoaApt
//
//  Created by 최민규 on 2023/08/01.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    @Published var authorisationStatus: CLAuthorizationStatus?
    
    var latitude: Double {
        locationManager.location?.coordinate.latitude ?? 37.566536
    }
    var longitude: Double {
        locationManager.location?.coordinate.longitude ?? 126.977966
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            //location services available
            authorisationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            break
        case .restricted:
            authorisationStatus = .restricted
            break
        case .denied:
            authorisationStatus = .denied
            break
        case .notDetermined:
            authorisationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error.localizedDescription)")
    }
}
