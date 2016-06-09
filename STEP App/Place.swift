//
//  Place.swift
//  STEP App
//
//  Created by Osaze Shears on 5/25/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import Foundation
import MapKit

class Place: NSObject, MKAnnotation {
    let title:String?
    let locationName:String!
    let isBuilding:Bool!
    let coordinate: CLLocationCoordinate2D
    init(name:String,location:String,isBuilding:Bool,coordinate:CLLocationCoordinate2D){
        self.title = name
        self.locationName = location
        self.isBuilding = isBuilding
        self.coordinate = coordinate
        super.init()
    }
    var subtitle: String? {
        return locationName
    }
    func pinColor() -> MKPinAnnotationColor  {
        return (isBuilding == true) ? .Red : .Green
    }
}