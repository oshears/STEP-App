//
//  CalendarTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 3/10/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class CalendarTableViewController: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var calendarDayList:NSMutableArray = NSMutableArray()
    var spinner:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //Side Menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Self Sizing Cells
        self.tableView.estimatedRowHeight = 131.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        //No excess
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        
        //Load Announcements
        self.loadCalendarDays()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return calendarDayList.count
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CalendarCell", forIndexPath: indexPath) as CalendarTableViewCell
        
        if (indexPath.row > calendarDayList.count){
            return cell
        }
        
        // Configure the cell...
        /*
        cell.dayLabel.alpha = 0
        cell..alpha = 0
        cell.announcementTitle.alpha = 0
        */
        
        
        let calendarDay:PFObject = self.calendarDayList.objectAtIndex(indexPath.row) as PFObject
        cell.mainActivity1.text = calendarDay.objectForKey("main_activity_1") as? String
        cell.mainActivity2.text = calendarDay.objectForKey("main_activity_2") as? String
        cell.mainActivity3.text = calendarDay.objectForKey("main_activity_3") as? String

        /*if self.spinner.isAnimating() {
            dispatch_async(dispatch_get_main_queue(), {
                self.spinner.stopAnimating()
            })
        }*/
        
        
        
        /*
        UIView.animateWithDuration(0.5, animations: {
            cell.announcementImage.alpha = 1
            cell.announcementTime.alpha = 1
            cell.announcementTitle.alpha = 1
        })
        */
        
        return cell


    }
    
    @IBAction func loadCalendarDays(){
        calendarDayList.removeAllObjects()
        var findCalendarDays:PFQuery = PFQuery(className: "CalendarDay")
        findCalendarDays.findObjectsInBackgroundWithBlock({
            (objects:[AnyObject]!,error:NSError!)->Void in
            
            if error == nil{
                for object in objects{
                    let calendarDay:PFObject = object as PFObject
                    self.calendarDayList.addObject(calendarDay)
                }
                let array:NSArray = self.calendarDayList.reverseObjectEnumerator().allObjects
                self.calendarDayList = NSMutableArray(array: array)
                self.tableView.reloadData()
            }
            else{
                println("Failed to retrieve announcements from database")
            }
            
        })
        self.refreshControl?.endRefreshing()
    
    }
    


}
