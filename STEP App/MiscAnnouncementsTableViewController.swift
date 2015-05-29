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
        refreshControl?.backgroundColor = UIColor(red: 240/255, green: 242/255, blue: 243/255, alpha: 1)
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
        
        var dataFormatter:NSDateFormatter = NSDateFormatter()
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
        var findAnnouncements:PFQuery = PFQuery(className: "MiscAnnouncement")
        //FindAnnouncements.findObjectsInBackgroundWithBlock
        /*
        findAnnouncements.findObjectsInBackgroundWithBlock({
            (objects:[AnyObject]!,error:NSError!)->Void in
            
            if error == nil{
                for object in objects{
                    let announcement:PFObject = object as PFObject
                    self.miscAnnouncementList.addObject(announcement)
                }
            
                let array:NSArray = self.miscAnnouncementList.reverseObjectEnumerator().allObjects
                self.miscAnnouncementList = NSMutableArray(array: array)
                self.tableView.reloadData()
            }
            else{
                println("Failed to retrieve announcements from database")
            }
        })*/
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
                println("Failed to retrieve announcements from database")
            }
        }
        self.refreshControl?.endRefreshing()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
