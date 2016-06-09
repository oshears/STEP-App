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
        
        Place(name: "Johnson Center (JC)", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.830113,-77.307650)),
        Place(name: "Student Union Building I (SUB I)", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.831808, -77.308679)),
        Place(name: "Office of Diversity, Inclusion and Multicultural Education (ODIME)", location:"George Mason University", isBuilding:false, coordinate: CLLocationCoordinate2DMake(38.831894, -77.308808)),
        Place(name: "David Krug Hall", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.830590, -77.306672)),
        Place(name: "Planetary Hall", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.829839, -77.306216)),
        Place(name: "Enterprise Hall", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.829067, -77.306067)),
        Place(name: "Innovation Hall", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.828606, -77.307353)),
        Place(name: "Robinson Hall A", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.831364, -77.307864)),
        Place(name: "Robinson Hall B", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.830930, -77.307992)),
        Place(name: "Eastern Shore", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.833371, -77.304262)),
        Place(name: "Center for the Arts", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.829482, -77.309533)),
        Place(name: "East Building", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.832990, -77.308256)),
        Place(name: "Nyguyen Engineering Building", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.827518, -77.305267)),
        Place(name: "Art and Design Building", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.827868, -77.306364)),
        Place(name: "Music and Theater Building", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.829271, -77.307990)),
        Place(name: "Merten Hall", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.834967, -77.307891)),
        Place(name: "Manhattan Pizza", location:"George Mason University", isBuilding:false, coordinate: CLLocationCoordinate2DMake(38.834970, -77.307449)),
        Place(name: "Panda Express", location:"George Mason University", isBuilding:false, coordinate: CLLocationCoordinate2DMake(38.834838, -77.308083)),
        Place(name: "Einstein's Bagels", location:"George Mason University", isBuilding:false, coordinate: CLLocationCoordinate2DMake(38.834927, -77.307809)),
        Place(name: "Eagle Bank Arena (Patriot Center)", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.826814, -77.309717)),
        Place(name: "Aquatic and Fitness Center (AFC)", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.826417, -77.304186)),
        Place(name: "Global Center", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.829622, -77.314867)),
        Place(name: "Recreation and Atheletic Complex", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.830579, -77.312287)),
        Place(name: "The HUB", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.830618, -77.304647)),
        Place(name: "Hanover Hall", location:"George Mason University", isBuilding:true, coordinate: CLLocationCoordinate2DMake(38.832137, -77.304812)),
        Place(name: "Subway", location:"George Mason University", isBuilding:false, coordinate: CLLocationCoordinate2DMake(38.834367, -77.310776)),
        Place(name: "The Globe", location:"George Mason University", isBuilding:false, coordinate: CLLocationCoordinate2DMake(38.829854, -77.314831)),
        Place(name: "Rathskeller", location:"George Mason University", isBuilding:false, coordinate: CLLocationCoordinate2DMake(38.831421, -77.308732)),
        Place(name: "Chick-Fil-A", location:"George Mason University", isBuilding:false, coordinate: CLLocationCoordinate2DMake(38.831592, -77.308877)),
        Place(name: "Panera Bread", location:"George Mason University", isBuilding:false, coordinate: CLLocationCoordinate2DMake(38.830384, -77.307412)),
        Place(name: "IndAroma", location:"George Mason University", isBuilding:false, coordinate: CLLocationCoordinate2DMake(38.830146, -77.307782)),
        Place(name: "Burger King", location:"George Mason University", isBuilding:false, coordinate: CLLocationCoordinate2DMake(38.830071, -77.307718)),
        Place(name: "Freshen's and Express (General Store)", location:"George Mason University", isBuilding:false, coordinate: CLLocationCoordinate2DMake(38.830021, -77.307198)),
        Place(name: "Red, Hot & Blue", location:"George Mason University", isBuilding:false, coordinate: CLLocationCoordinate2DMake(38.830079, -77.307793)),
        Place(name: "Starbucks", location:"George Mason University", isBuilding:false, coordinate: CLLocationCoordinate2DMake(38.829649, -77.307053)),
        Place(name: "Jorge's", location:"George Mason University", isBuilding:false, coordinate: CLLocationCoordinate2DMake(38.829887, -77.307611)),
    ]
    
    //Center on the middle of George Mason
    let initialLocation = CLLocation(latitude: 38.830113,longitude: -77.307650)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //Side Menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //Center Map on Mason
        centerMapOnLocation(initialLocation)
        //Add Pins
        mapView.addAnnotations(places)
        
        //Set maptype
        mapView.delegate = self
        mapView.mapType = MKMapType.Hybrid
        
        //User location setup
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
    
    //Helper method for centering the map on a region
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
    
    //The below code pertains to the user's location
    //This code creates a CLLocationManager object, which keeps track of your app’s authorization status for accessing the user’s location.
    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                print("Error:" + error!.localizedDescription)
                return
                
            }
            if placemarks!.count > 0 {
                
                let pm = placemarks![0] 
                self.displayLocationInfo(pm)
            }else {
                print("Error with data")
            }
        })
    }
    func displayLocationInfo(placemark: CLPlacemark) {
        self.locationManager.stopUpdatingLocation()
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
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
