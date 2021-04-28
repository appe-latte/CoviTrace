//
//  LocationFetch.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/02/2021.
//

import CoreLocation
import Combine

class LocationFetch: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var lastLocation: CLLocationCoordinate2D?
    let objectWillChange = PassthroughSubject<Void, Never>()
    var locationdetails: [CLLocation]?

    @Published var status: CLAuthorizationStatus?{
        willSet { objectWillChange.send() }
    }
    
    @Published var location: CLLocation? {
        willSet{ objectWillChange.send() }
    }
    
    override init() {
        super.init()
        
        // MARK: Location request
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        self.status = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        lastLocation = locations.first?.coordinate
    }
}

