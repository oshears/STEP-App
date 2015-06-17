//
//  AnnouncementsTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 3/8/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class AnnouncementsTableViewController: UITableViewController, UINavigationControllerDelegate {

    var announcementList:NSMutableArray = NSMutableArray()
    var spinner:UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
        // Empty back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        // Self Sizing Cells
        self.tableView.estimatedRowHeight = 100.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        //No excess
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        
        //Load Announcements
        self.loadAnnouncementData()
        
        //Enable Push Notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadAnnouncementData", name: "reloadAnnouncements", object: nil)
        
        //Change Separator Color
        self.tableView.separatorColor = UIColor.clearColor()
        
        //Side Menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Pull To Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor(red: 220/255, green: 222/255, blue: 223/255, alpha: 1)
        refreshControl?.tintColor = UIColor.grayColor()
        refreshControl?.addTarget(self, action: "loadAnnouncementData", forControlEvents:
        UIControlEvents.ValueChanged)

        
        // Configure the activity indicator and start animating
        spinner.activityIndicatorViewStyle = .Gray
        spinner.center = self.view.center
        spinner.hidesWhenStopped = true
        self.parentViewController?.view.addSubview(spinner)
        spinner.startAnimating()
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return announcementList.count
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! AnnoucementTableViewCell
        
        if (indexPath.row > announcementList.count){
            return cell
        }
        
        // Configure the cell...
        cell.announcementImage.alpha = 0
        cell.announcementTime.alpha = 0
        cell.announcementTitle.alpha = 0
        
        
        
        let announcement:PFObject = self.announcementList.objectAtIndex(indexPath.row) as! PFObject
        
        
        
        cell.announcementTitle.text = announcement.objectForKey("title") as? String
        
        var dataFormatter:NSDateFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "yyy-MM-dd HH:mm"
        cell.announcementTime.text = dataFormatter.stringFromDate(announcement.createdAt!)
        
        if announcement.objectForKey("type") != nil{
            if announcement.objectForKey("type") as? Int != nil{
                if announcement.objectForKey("type") as? Int == 0{
                    cell.announcementImage.image = UIImage(named: "type_General")
                }
                if announcement.objectForKey("type") as? Int == 1{
                    cell.announcementImage.image = UIImage(named: "type_Urgent")
                }
                if announcement.objectForKey("type") as? Int == 2{
                    cell.announcementImage.image = UIImage(named: "type_Informative")
                }
            }
        }
        else{
            var titleText:String = announcement.objectForKey("title") as! String
            println("found a nil type announcement with title: \(titleText)")
        }
        cell.announcementImage.layer.cornerRadius = cell.announcementImage.frame.size.width / 2
        
        if self.spinner.isAnimating() {
            dispatch_async(dispatch_get_main_queue(), {
                self.spinner.stopAnimating()
            })
        }


        UIView.animateWithDuration(0.5, animations: {
            cell.announcementImage.alpha = 1
            cell.announcementTime.alpha = 1
            cell.announcementTitle.alpha = 1
        })

        /*
        //Dynamic Cell Height Fix?
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        */
        cell.setNeedsDisplay()
        return cell
    }
    
    
    @IBAction func loadAnnouncementData(){
            announcementList.removeAllObjects()
            var findAnnouncements:PFQuery = PFQuery(className: "Announcement")
        
        findAnnouncements.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]?,error:NSError?)-> Void in
                if error == nil{
                    for object in objects!{
                        let announcement:PFObject = object as! PFObject
                        self.announcementList.addObject(announcement)
                    }
                    let array:NSArray = self.announcementList.reverseObjectEnumerator().allObjects
                    self.announcementList = NSMutableArray(array: array)
                    self.tableView.reloadData()
                }
                else{
                    println("Failed to retrieve announcements from database")
                    var errorAlert:UIAlertController = UIAlertController(title: "Failed to connect to the internet", message: "Check network connection and try again.", preferredStyle: UIAlertControllerStyle.Alert)
                    errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                    self.presentViewController(errorAlert,animated: true, completion: nil)
                }
            }
        
    
            //Save to local datastore
            PFObject.pinAllInBackground(announcementList as [AnyObject], block: nil)
            //Remove from local datastore
            PFObject.unpinAllInBackground(announcementList as [AnyObject], block: nil)
            self.refreshControl?.endRefreshing()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "detailedAnnouncement" {
            if let row = tableView.indexPathForSelectedRow()?.row {
                
                //var retrievedAnnouncement:PFObject = announcementList[row] as PFObject
                let announcement:PFObject = self.announcementList.objectAtIndex(row) as! PFObject
                var title:String = announcement.objectForKey("title") as! String
                var content:String = announcement.objectForKey("content") as! String
                
                var dataFormatter:NSDateFormatter = NSDateFormatter()
                dataFormatter.dateFormat = "yyy-MM-dd HH:mm"
                var postDate:String = dataFormatter.stringFromDate(announcement.createdAt!)
                
                
                let destinationController = segue.destinationViewController as! AnnouncementConentTableViewController
                
                
                destinationController.announcement = Announcement(title: title, content: content, postDate: postDate)
                
                destinationController.hidesBottomBarWhenPushed = true
            }
        }
        
    }
    

    @IBAction func unwindToAnnouncementScreen(segue:UIStoryboardSegue) {
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row==self.tableView.indexPathsForVisibleRows()?.first?.row ){
            // Launch walkthrough screens
            let defaults = NSUserDefaults.standardUserDefaults()
            let hasViewedWalkthrough = defaults.boolForKey("hasViewedAnnouncementPopTip")
            
            if hasViewedWalkthrough == false {
                defaults.setBool(true, forKey: "hasViewedAnnouncementPopTip")
                showPopTip(cell,message: "Tap announcements for more information.")
                showPopTip(menuButton, message: "Tap the menu to view other information.")
            }
        }
    }
    
    func showPopTip(sender: AnyObject, message: String) {
        var popTip = SwiftPopTipView(title: "ProTip!", message: message)
        popTip.popColor = UIColor(red: 0/255, green: 102/255, blue: 51/255, alpha: 1)
        popTip.titleColor = UIColor.whiteColor()
        popTip.textColor = UIColor.whiteColor()
        if sender.dynamicType === UIBarButtonItem.self {
            popTip.presentAnimatedPointingAtBarButtonItem(sender as! UIBarButtonItem, autodismissAtTime: 10)
        } else {
            popTip.presentAnimatedPointingAtView(sender as! UIView, inView: self.view, autodismissAtTime: 10)
        }
    }

}
