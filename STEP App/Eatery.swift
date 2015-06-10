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
    var desc:String
    var isClosed:Bool = false
    var openTimes:[Double]
    var closeTimes:[Double]
    
    init(title:String, weekHours:String, weekendHours:String, image:String, desc:String,openTimes:[Double],closeTimes:[Double]){
        
        self.title = title
        self.weekHours = weekHours
        self.weekendHours = weekendHours
        self.image = image
        self.desc = desc
        self.openTimes = openTimes
        self.closeTimes = closeTimes
        fixOpenStatus()
    }
    
    func fixOpenStatus(){
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitDay | .CalendarUnitWeekday | .CalendarUnitMonth, fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        let day = components.day
        let weekday = components.weekday
        let month = components.month
        //println("Some date today is: \(hour):\(minutes), on \(weekday) \(month) \(day)")
        var currTime:Double = Double(hour)
        if (minutes>=30){ currTime+=0.5}
        //println("Current time representation: \(currTime)")
        if (openTimes[weekday-1] == -1){
            //println("\(title) is not open")
            isClosed=true
            return
        }
        if (currTime<openTimes[weekday-1] || currTime>closeTimes[weekday-1]){
            //println("\(title) is not open")
            isClosed=true
        }
        
        
        
        
    }

    
}