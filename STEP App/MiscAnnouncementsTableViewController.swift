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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as MiscAnnouncementTableViewCell
        
        // Configure the cell...
        cell.announcementTime.alpha = 0
        cell.announcementContent.alpha = 0
        
        
        let announcement:PFObject = self.miscAnnouncementList.objectAtIndex(indexPath.row) as PFObject
        cell.announcementContent.text = announcement.objectForKey("content") as? String
        
        var dataFormatter:NSDateFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "yyy-MM-dd HH:mm"
        cell.announcementTime.text = dataFormatter.stringFromDate(announcement.createdAt)
        
        
        
        UIView.animateWithDuration(0.5, animations: {
            cell.announcementTime.alpha = 1
            cell.announcementContent.alpha = 1
        })
        
        //cell.cellSize = tableView(self.tableView, heightForRowAtIndexPath: indexPath)
        
        
        cell.cellSize = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        
            
        return cell
    }

    
    @IBAction func loadAnnouncementData(){
        miscAnnouncementList.removeAllObjects()
        var findAnnouncements:PFQuery = PFQuery(className: "MiscAnnouncement")
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
            
        })
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
