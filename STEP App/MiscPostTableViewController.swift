//
//  MiscPostTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 3/10/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class MiscPostTableViewController: UITableViewController, UINavigationControllerDelegate, UITextViewDelegate {
    

    @IBOutlet weak var announcementContent: UITextView!
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    @IBAction func postMisc(){
        var notBlank = announcementContent.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != ""
        if notBlank{
            var announcement:PFObject = PFObject(className: "MiscAnnouncement")
            announcement["content"] = announcementContent.text
        
            //Create a check here to determine if PFUser is nil or not
            announcement.saveInBackgroundWithTarget(nil, selector: nil)
            var push:PFPush = PFPush()
            push.setChannel("Reload")
            
            //Custom sound, badge app icon, alert message?
            var data:NSDictionary = ["alert":"","badge":"0","content-available":"1","sound":""]
            push.setData(data as [NSObject : AnyObject])
            push.sendPushInBackgroundWithTarget(nil, selector: nil)
            
            performSegueWithIdentifier("unwindToAnnouncementScreen", sender: self)
        }
        else{
            var errorAlert:UIAlertController = UIAlertController(title: "Textfields Not Filled", message: "Please fill out all textfields before posting an announcement.", preferredStyle: UIAlertControllerStyle.Alert)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(errorAlert,animated: true, completion: nil)
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
