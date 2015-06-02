//
//  DetailedCalendarTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 5/31/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class DetailedCalendarTableViewController: UITableViewController {

    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var activity1Label: UILabel!
    @IBOutlet weak var activity2Label: UILabel!
    @IBOutlet weak var activity3Label: UILabel!
    @IBOutlet weak var moreInfoLabel: UILabel!
    
    var calendarDay:PFObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        topicLabel.text = (calendarDay.objectForKey("weekTopic")==nil) ? "" : calendarDay.objectForKey("weekTopic") as? String
        
        activity1Label.text = (calendarDay.objectForKey("main_activity_1")==nil) ? "" : calendarDay.objectForKey("main_activity_1") as? String
        //if (activity1Label.text == ""){ activity1Label.text = " "}
        activity2Label.text = (calendarDay.objectForKey("main_activity_2")==nil) ? "" : calendarDay.objectForKey("main_activity_2") as? String
        //if (activity2Label.text == ""){ activity2Label.text = " "}
        activity3Label.text = (calendarDay.objectForKey("main_activity_3")==nil) ? "" : calendarDay.objectForKey("main_activity_3") as? String
        //if (activity3Label.text == ""){ activity3Label.text = " "}
        
        var calendarDate = calendarDay.objectForKey("date") as! NSDate
        var dataFormatter:NSDateFormatter = NSDateFormatter()
        dataFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
        
        dataFormatter.dateFormat = "EEEE, MMMM dd, YYYY"
        dateLabel.text = dataFormatter.stringFromDate(calendarDate)
        dataFormatter.dateFormat = "dd"
        dayLabel.text = dataFormatter.stringFromDate(calendarDate)
        dataFormatter.dateFormat = "MMMM"
        monthLabel.text = dataFormatter.stringFromDate(calendarDate)
        
        moreInfoLabel.text=""
        
        
        // Self Sizing Cells
        self.tableView.estimatedRowHeight = 100.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
