//
//  Eatery.swift
//  STEP App
//
//  Created by Osaze Shears on 3/27/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import Foundation

class Eatery {
    
    var title:String
    var weekHours:String
    var weekendHours:String
    var image:String
    
    init(title:String, weekHours:String, weekendHours:String, image:String){
        
        self.title = title
        self.weekHours = weekHours
        self.weekendHours = weekendHours
        self.image = image
        
    }

    
}