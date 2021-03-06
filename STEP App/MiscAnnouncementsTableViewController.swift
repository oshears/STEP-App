//
//  MiscAnnouncementsTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 3/9/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class MiscAnnouncementsTableViewController: UITableViewController {

    var miscAnnouncementList:NSMutableArray = NSMutableArray()
    var spinner:UIActivityIndicatorView = UIActivityIndicatorView()
    var countReloads:Int = 0

    @IBOutlet weak var postMiscBtn: UIBarButtonItem!
    
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
        
        self.loadAnnouncementData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MiscAnnouncementsTableViewController.loadAnnouncementData), name: "reloadAnnouncements", object: nil)
        
        //Change Separator Color
        //self.tableView.separatorColor = UIColor.clearColor()
        
        //Side Menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Pull To Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor(red: 240/255, green: 242/255, blue: 243/255, alpha: 1)
        refreshControl?.tintColor = UIColor.grayColor()
        refreshControl?.addTarget(self, action: #selector(MiscAnnouncementsTableViewController.loadAnnouncementData), forControlEvents:
        UIControlEvents.ValueChanged)
        
        // Configure the activity indicator and start animating
        spinner.activityIndicatorViewStyle = .Gray
        spinner.center = self.view.center
        spinner.hidesWhenStopped = true
        self.parentViewController?.view.addSubview(spinner)
        spinner.startAnimating()
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        
        //Misc Announcement Count
        return miscAnnouncementList.count
    }
    
    @IBAction func unwindToAnnouncementScreen(segue:UIStoryboardSegue) {
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MiscAnnouncementTableViewCell
        
        if (indexPath.row > miscAnnouncementList.count){
            return cell
        }
        
        // Configure the cell...
        cell.announcementTime.alpha = 0
        cell.announcementContent.alpha = 0
        
        
        let announcement:PFObject = self.miscAnnouncementList.objectAtIndex(indexPath.row) as! PFObject
        cell.announcementContent.text = announcement.objectForKey("content") as? String
        
        let dataFormatter:NSDateFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "yyy-MM-dd HH:mm"
        cell.announcementTime.text = dataFormatter.stringFromDate(announcement.createdAt!)
        
        if self.spinner.isAnimating() {
            dispatch_async(dispatch_get_main_queue(), {
                self.spinner.stopAnimating()
            })
        }
        UIView.animateWithDuration(0.5, animations: {
            cell.announcementTime.alpha = 1
            cell.announcementContent.alpha = 1
        })
        
        cell.cellSize = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        
        
        return cell
    }

    
    @IBAction func loadAnnouncementData(){
        miscAnnouncementList.removeAllObjects()
        let findAnnouncements:PFQuery = PFQuery(className: "MiscAnnouncement")
        findAnnouncements.orderByAscending("createdAt")
        findAnnouncements.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]?,error:NSError?)-> Void in
            if error == nil{
                for object in objects! {
                    let announcement:PFObject = object as! PFObject
                    self.miscAnnouncementList.addObject(announcement)
                }
                
                let array:NSArray = self.miscAnnouncementList.reverseObjectEnumerator().allObjects
                self.miscAnnouncementList = NSMutableArray(array: array)
                self.tableView.reloadData()
            }
            else{
                print("Failed to retrieve announcements from database")
                let errorAlert:UIAlertController = UIAlertController(title: "Failed to connect to the internet", message: "Check network connection and try again.", preferredStyle: UIAlertControllerStyle.Alert)
                errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(errorAlert,animated: true, completion: nil)
            }
        }
        self.refreshControl?.endRefreshing()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row==self.tableView.indexPathsForVisibleRows?.first?.row ){
                // Launch walkthrough screens
                let defaults = NSUserDefaults.standardUserDefaults()
                let hasViewedWalkthrough = defaults.boolForKey("hasViewedMiscAnnouncementPopTip")
                
                if hasViewedWalkthrough == false {
                    defaults.setBool(true, forKey: "hasViewedMiscAnnouncementPopTip")
                    showPopTip(cell,message: "View announcements posted by everyone.")
                    showPopTip(postMiscBtn,message:"Tap the plus to post a new announcement.")
                }
            }
        if (indexPath.row==self.tableView.indexPathsForVisibleRows?.last?.row && countReloads<2){
            countReloads += 1
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
    func showPopTip(sender: AnyObject, message: String) {
        let popTip = SwiftPopTipView(title: "ProTip!", message: message)
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
