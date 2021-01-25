//
//  MapView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 20/01/2021.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        setupManager()
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
    }
}

var locationManager = CLLocationManager()

func setupManager() {
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestAlwaysAuthorization()
}


