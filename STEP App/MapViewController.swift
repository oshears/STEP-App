//
//  MapViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 5/13/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var mapView:MKMapView!
    
    //List of places
    var places:[Place] = [
        
        Place(name: "Johnson Center", location:"George Mason", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.830113,-77.307650)),
        Place(name: "SUB I", location:"George Mason", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.831808, -77.308679))
    ]
    
    let initialLocation = CLLocation(latitude: 38.830113,longitude: -77.307650)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //Side Menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //Center Map on Mason
        centerMapOnLocation(initialLocation)
        //Add Pins
        mapView.addAnnotations(places)
        
        //Set maptype
        mapView.delegate = self
        mapView.mapType = MKMapType.Hybrid
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This code creates a CLLocationManager object, which keeps track of your app’s authorization status for accessing the user’s location.
    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                println("Error:" + error.localizedDescription)
                return
                
            }
            if placemarks.count > 0 {
                
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
            }else {
                println("Error with data")
            }
        })
    }
    func displayLocationInfo(placemark: CLPlacemark) {
        self.locationManager.stopUpdatingLocation()
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
