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

class mapViewController: UIViewController,CLLocationManagerDelegate{

    
    @IBOutlet weak var mapView: MKMapView!
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region,animated:true)
        
        self.mapView.showsUserLocation=true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for Authorisation from the User.
        manager.requestAlwaysAuthorization()
        
        // For use in foreground
        manager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
           manager.delegate = self
           manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
           manager.requestWhenInUseAuthorization()
           manager.startUpdatingLocation()
            
        }
    
    }
        
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
