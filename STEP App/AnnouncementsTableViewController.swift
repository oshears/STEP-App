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
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        
        self.loadAnnouncementData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadAnnouncementData", name: "reloadAnnouncements", object: nil)
        
        //Side Menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
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
    
    func navigationController(navigationController: UINavigationController!, willShowViewController viewController: UIViewController!, animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as AnnoucementTableViewCell
        
        // Configure the cell...
        cell.announcementImage.alpha = 0
        cell.announcementTime.alpha = 0
        cell.announcementTitle.alpha = 0
        
        
        let announcement:PFObject = self.announcementList.objectAtIndex(indexPath.row) as PFObject
        cell.announcementTitle.text = announcement.objectForKey("title") as? String
        //println("Announcement! - \(cell.announcementTitle.text)")
        /*
        var findPoster:PFQuery = PFUser.query()
        findSweeter.whereKey("objectId", equalTo: sweet.objectForKey("sweeter").objectId)
        findSweeter.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!,error:NSError!)->Void in
            if error == nil{
                
                let user:PFUser = (objects as NSArray).lastObject as PFUser
                cell.sweetUserLabel.text = user.username
                
                //Profile Image
                let profileImage:PFFile = user["profileImage"] as PFFile
                
                profileImage.getDataInBackgroundWithBlock({
                    (imageData:NSData!,error:NSError!)->Void in
                    if (error==nil){
                        let image:UIImage = UIImage(data:imageData)!
                        cell.profileImageView.image = image
                    }
                })
                
            }
        }*/
        
        var dataFormatter:NSDateFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "yyy-MM-dd HH:mm"
        cell.announcementTime.text = dataFormatter.stringFromDate(announcement.createdAt)
        
        if announcement.objectForKey("type") != nil{
            if announcement.objectForKey("type") as? Int != nil{
                if announcement.objectForKey("type") as? Int == 0{
                    cell.announcementImage.image = UIImage(named: "generalb")
                }
                if announcement.objectForKey("type") as? Int == 1{
                    cell.announcementImage.image = UIImage(named: "urgent")
                }
                if announcement.objectForKey("type") as? Int == 2{
                    cell.announcementImage.image = UIImage(named: "informative")
                }
            }
        }
        
        
        
        UIView.animateWithDuration(0.5, animations: {
            cell.announcementImage.alpha = 1
            cell.announcementTime.alpha = 1
            cell.announcementTitle.alpha = 1
        })

        return cell
    }
    
    @IBAction func loadAnnouncementData(){
            announcementList.removeAllObjects()
            var findAnnouncements:PFQuery = PFQuery(className: "Announcement")
            findAnnouncements.findObjectsInBackgroundWithBlock({
                (objects:[AnyObject]!,error:NSError!)->Void in
                
                if error == nil{
                    println("No errors, getting announcements")
                    for object in objects{
                        let announcement:PFObject = object as PFObject
                        self.announcementList.addObject(announcement)
                    }
                    println("Retrieved: \(self.announcementList.count) announcements...")
                    let array:NSArray = self.announcementList.reverseObjectEnumerator().allObjects
                    self.announcementList = NSMutableArray(array: array)
                    self.tableView.reloadData()
                }
                else{
                    println("Failed to retrieve announcements from database")
                }
                
            })
    }
    

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
