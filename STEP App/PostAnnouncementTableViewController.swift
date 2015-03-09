//
//  PostAnnouncementTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 3/9/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class PostAnnouncementTableViewController: UITableViewController, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var announcementTitle: UITextField!
    @IBOutlet weak var announcementContent: UITextView!
    
    @IBOutlet weak var generalButton: UIButton!
    @IBOutlet weak var urgentButton: UIButton!
    @IBOutlet weak var informativeButton: UIButton!
    
    var announcementType:Int = -1
    //var announcementImage:UIImage; //Not implimented yet
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        announcementContent.layer.borderColor = UIColor.blackColor().CGColor
        announcementContent.layer.borderWidth = 0.5
        announcementContent.layer.cornerRadius = 5
        announcementContent.delegate = self
        announcementContent.becomeFirstResponder()
        
        announcementTitle.becomeFirstResponder()
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
        return 3
    }
    
    func navigationController(navigationController: UINavigationController!, willShowViewController viewController: UIViewController!, animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }
    
    @IBAction func postAnnouncement(sender: AnyObject) {
        var announcement:PFObject = PFObject(className: "Announcement")
        announcement["title"] = announcementTitle.text
        announcement["content"] = announcementContent.text
        
        //Create a check here to determine if PFUser is nil or not
        if PFUser.currentUser() != nil{
            announcement["poster"] = PFUser.currentUser()
            announcement.saveInBackgroundWithTarget(nil, selector: nil)
            var push:PFPush = PFPush()
            push.setChannel("Reload")
            
            //Custom sound, badge app icon, alert message?
            var data:NSDictionary = ["alert":"","badge":"0","content-available":"1","sound":""]
            
            push.setData(data)
            push.sendPushInBackgroundWithTarget(nil, selector: nil)
            
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBAction func updateAnnouncementType(sender: AnyObject){
        let buttonClicked = sender as UIButton
        if buttonClicked == generalButton {
            announcementType = 0
            generalButton.backgroundColor = UIColor(red: 175.0/255.0, green: 210.0/255.0, blue: 63.0/255.0, alpha: 1.0)
            urgentButton.backgroundColor = UIColor.clearColor()
            informativeButton.backgroundColor = UIColor.clearColor()
        } else if buttonClicked == urgentButton {
            announcementType = 1
            generalButton.backgroundColor = UIColor.clearColor()
            urgentButton.backgroundColor = UIColor(red: 175.0/255.0, green: 210.0/255.0, blue: 63.0/255.0, alpha: 1.0)
            informativeButton.backgroundColor = UIColor.clearColor()
        }
        else if buttonClicked == informativeButton{
            announcementType = 2
            generalButton.backgroundColor = UIColor.clearColor()
            urgentButton.backgroundColor = UIColor.clearColor()
            informativeButton.backgroundColor = UIColor(red: 175.0/255.0, green: 210.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        }

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
