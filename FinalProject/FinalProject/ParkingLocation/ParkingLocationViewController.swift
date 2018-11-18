//
//  ParkingSpotViewController.swift
//  FinalProject
//
//  Created by Giselle Tavares on 13/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit
import MapKit

class ParkingLocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapLocation: MKMapView!
    var locationManager = CLLocationManager()
    var currentLatitude: Double?
    var currentLongitude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Location"
        
        mapLocation.delegate = self
        locationManager.delegate = self
        
        // To get authorization to get the current location
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
            mapLocation.setRegion(viewRegion, animated: false)
        }
        
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }

    }
    
    @IBAction func segChangeMapType(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            mapLocation.mapType = MKMapType.standard
        case 1:
            mapLocation.mapType = MKMapType.satellite
        case 2:
            mapLocation.mapType = MKMapType.hybrid
        default:
            mapLocation.mapType = MKMapType.standard
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        currentLatitude = locValue.latitude
        currentLongitude = locValue.longitude
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        // spotLocation = lambton location
        let spotLocation = CLLocationCoordinate2DMake(43.776394, -79.3332287)
        let currentLocation = CLLocationCoordinate2DMake(currentLatitude ?? 43.773318, currentLongitude ?? -79.3360205)
        
        let spotPlacemark = MKPlacemark(coordinate: spotLocation, addressDictionary: nil)
        let currentPlacemark = MKPlacemark(coordinate: currentLocation, addressDictionary: nil)
        
        let spotMapItem = MKMapItem(placemark: spotPlacemark)
        let currentMapItem = MKMapItem(placemark: currentPlacemark)
        
        let currentAnnotation = MKPointAnnotation()
        currentAnnotation.title = "You are here!"
        
        if let location = currentPlacemark.location {
            currentAnnotation.coordinate = location.coordinate
        }
        
        let spotAnnotation = MKPointAnnotation()
        spotAnnotation.title = "Lambton Parking Lot"
        
        if let location = spotPlacemark.location {
            spotAnnotation.coordinate = location.coordinate
        }
        
        self.mapLocation.showAnnotations([currentAnnotation, spotAnnotation], animated: true)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = currentMapItem
        directionRequest.destination = spotMapItem
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { (response, error) -> Void in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapLocation.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapLocation.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 5
    
        return renderer
    }
}
