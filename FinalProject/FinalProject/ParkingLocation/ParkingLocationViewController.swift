//
//  ParkingSpotViewController.swift
//  FinalProject
//
//  Created by Giselle Tavares on 13/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit
import MapKit

class ParkingLocationViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapLocation: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Location"
        
        mapLocation.delegate = self
        
        let spotLocation = CLLocationCoordinate2DMake(43.7732946, -79.3380697)
        
        let spotPlacemark = MKPlacemark(coordinate: spotLocation, addressDictionary: nil)
    
        let spotAnnotation = MKPointAnnotation()
        spotAnnotation.title = "Lambton Parking Lot"

        if let location = spotPlacemark.location {
            spotAnnotation.coordinate = location.coordinate
        }

        self.mapLocation.showAnnotations([spotAnnotation], animated: true)
    }
}
