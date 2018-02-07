//
//  mapViewController.swift
//  MyTraveNote
//
//  Created by user134225 on 2018-02-07.
//  Copyright © 2018 user134225. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapViewController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate{

    
    @IBOutlet weak var mapView: MKMapView!
    var address:String = ""
    var locationManager:CLLocationManager!
    var myLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        mapView.showsUserLocation = true
        
        
        CLGeocoder().geocodeAddressString(address, completionHandler: {(placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                let annotation = MKPointAnnotation()
                
                if let rLocation = placemark.location {
                    self.restLocation = rLocation
                    annotation.coordinate = self.restLocation.coordinate
                    annotation.title = self.name
                    
                    let distance = self.myLocation.distance(from: self.restLocation)
                    //                    let distString = String(format: "%.1f", distance/1000)
                    //                    annotation.title = self.name + "\n" + distString + " km"
                    self.mapView.addAnnotation(annotation)
                    
                    let region = MKCoordinateRegionMakeWithDistance(self.restLocation.coordinate, 2*distance, 2*distance)
                    self.mapView.setRegion(region, animated: false)
                    self.findMyLocation()
                }
            }
        })
    }
    
    func findMyLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 3.0
        renderer.strokeColor = UIColor.purple
        renderer.alpha = 0.5
        return renderer
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
