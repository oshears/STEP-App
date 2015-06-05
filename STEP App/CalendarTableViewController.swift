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
    var reloaded:Bool = false
    
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
        
        
        
        //No excess
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        
        //Load Announcements
        self.loadCalendarDays()
        
        // Pull To Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor(red: 240/255, green: 242/255, blue: 243/255, alpha: 1)
        refreshControl?.tintColor = UIColor.grayColor()
        refreshControl?.addTarget(self, action: "loadCalendarDays", forControlEvents:
            UIControlEvents.ValueChanged)
        
        
        // Configure the activity indicator and start animating
        spinner.activityIndicatorViewStyle = .Gray
        spinner.center = self.view.center
        spinner.hidesWhenStopped = true
        self.parentViewController?.view.addSubview(spinner)
        spinner.startAnimating()
 
        
        // Self Sizing Cells
        self.tableView.estimatedRowHeight = 131.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        //self.tableView.beginUpdates()
        //self.tableView.endUpdates()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        /*
        Below is an unfinished implimentation of the autonomous scolling to a specific date
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        NSCalendarUnit.CalendarUnitMonth
        let components = calendar.components
        
        var indexPathForRow:NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        tableView.scrollToRowAtIndexPath( indexPathForRow, atScrollPosition: UITableViewScrollPosition.Middle, animated: false)
        */
        if (indexPath.row==self.tableView.indexPathsForVisibleRows()?.last?.row && !reloaded){
            reloaded=true
            tableView.reloadData()
        }

        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("CalendarCell", forIndexPath: indexPath) as! CalendarTableViewCell
        
        if (indexPath.row > calendarDayList.count){
            return cell
        }
        
        // Configure the cell...
        
        cell.mainActivity1.alpha = 0
        cell.mainActivity2.alpha = 0
        cell.mainActivity3.alpha = 0
        cell.dayLabelView.alpha = 0
        cell.monthLabelView.alpha = 0
        cell.fulldateLabel.alpha = 0
        
        
        let calendarDay:PFObject = self.calendarDayList.objectAtIndex(indexPath.row) as! PFObject
        cell.mainActivity1.text = calendarDay.objectForKey("main_activity_1") as? String
        if (cell.mainActivity1.text == ""){ cell.mainActivity1.text = " "}
        cell.mainActivity2.text = calendarDay.objectForKey("main_activity_2") as? String
        if (cell.mainActivity2.text == ""){ cell.mainActivity2.text = " "}
        cell.mainActivity3.text = calendarDay.objectForKey("main_activity_3") as? String
        if (cell.mainActivity3.text == ""){ cell.mainActivity3.text = " "}
        
        var calendarDate = calendarDay.objectForKey("date") as! NSDate
        var dataFormatter:NSDateFormatter = NSDateFormatter()
        dataFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
        
        dataFormatter.dateFormat = "EEEE, MMMM dd, YYYY"
        cell.fulldateLabel.text = dataFormatter.stringFromDate(calendarDate)
        dataFormatter.dateFormat = "dd"
        cell.dayLabel.text = dataFormatter.stringFromDate(calendarDate)
        dataFormatter.dateFormat = "MMMM"
        cell.monthLabel.text = dataFormatter.stringFromDate(calendarDate)
        
        //cell.monthLabel.text = calendarDay.objectForKey("date") as? String
        //cell.dayLabel.text = calendarDay.objectForKey("date") as? String
        //cell.fulldateLabel.text = calendarDay.objectForKey("date") as? String

        
        if self.spinner.isAnimating() {
            dispatch_async(dispatch_get_main_queue(), {
                self.spinner.stopAnimating()
            })
        }
        
        
        UIView.animateWithDuration(0.5, animations: {
            cell.mainActivity1.alpha = 1
            cell.mainActivity2.alpha = 1
            cell.mainActivity3.alpha = 1
            cell.dayLabelView.alpha = 1
            cell.monthLabelView.alpha = 1
            cell.fulldateLabel.alpha=1
        })


        //cell.setNeedsDisplay()
        //cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
    
    @IBAction func loadCalendarDays(){
        calendarDayList.removeAllObjects()
        var findCalendarDays:PFQuery = PFQuery(className: "CalendarDay")
        findCalendarDays.orderByDescending("date")

        findCalendarDays.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]?,error:NSError?)-> Void in
            if error == nil{
                for object in objects! {
                    let calendarDay:PFObject = object as! PFObject
                    self.calendarDayList.addObject(calendarDay)
                }
                let array:NSArray = self.calendarDayList.reverseObjectEnumerator().allObjects
                self.calendarDayList = NSMutableArray(array: array)
                self.tableView.reloadData()
            }
            else{
                println("Failed to retrieve calendar information from database")
                var errorAlert:UIAlertController = UIAlertController(title: "Failed to connect to the internet", message: "Check network connection and try again.", preferredStyle: UIAlertControllerStyle.Alert)
                errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(errorAlert,animated: true, completion: nil)
            }
        }
        self.refreshControl?.endRefreshing()
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "detailDay" {
            if let row = tableView.indexPathForSelectedRow()?.row {
                let destinationController = segue.destinationViewController as! DetailedCalendarTableViewController
                let calendarDay:PFObject = self.calendarDayList.objectAtIndex(row) as! PFObject
                destinationController.calendarDay = calendarDay
                destinationController.hidesBottomBarWhenPushed = true
            }
        }
        
    }
    @IBAction func unwindToPeopleScreen(segue:UIStoryboardSegue) {
        
    }
    override func viewDidAppear(animated: Bool) {
        
    }
    
    /*
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row==self.tableView.indexPathsForVisibleRows()?.last?.row){
            tableView.reloadData()
        }
    }*/
    


}
