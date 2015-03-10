//
//  Announcement.swift
//  STEP App
//
//  Created by Osaze Shears on 3/9/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import Foundation
import UIKit

class Announcement {
    
    var title:String = ""
    var content:String = ""
    var image:UIImage = UIImage(named: "STEPAppLogoAsmallx")!
    var hasImage:Bool = false
    var postDate:String = ""
    
    func Announcement(title:String, content:String, image:UIImage, hasImage:Bool, postDate:String){
        
        self.title = title
        self.content = content
        self.image = image
        self.hasImage = hasImage
        self.postDate = postDate
        
    }
    
    func getImage() -> UIImage{
        if hasImage{
            return self.image
        }
        return UIImage(named: "STEPAppLogoAsmallx")!
    }
    
}