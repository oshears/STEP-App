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
    
    @IBOutlet weak var generalText: UILabel!
    @IBOutlet weak var urgentText: UILabel!
    @IBOutlet weak var infoText: UILabel!
    
    var announcementType:Int = -1
    //var announcementImage:UIImage; //Not implimented yet
    var announcementHasImage = false
    
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
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }
    
    
    @IBAction func postAnnouncement(sender: AnyObject) {
        let notBlank = announcementTitle.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != "" && announcementContent.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != ""
        if notBlank{
            let announcement:PFObject = PFObject(className: "Announcement")
            announcement["title"] = announcementTitle.text
            announcement["content"] = announcementContent.text
            announcement["type"] = announcementType
            announcement["hasImage"] = announcementHasImage
            print("New Announcement with image of \(announcementType)")
        
            if PFUser.currentUser() != nil{
                announcement["poster"] = PFUser.currentUser()
                announcement.saveInBackgroundWithTarget(nil, selector: nil)
                let push:PFPush = PFPush()
                //push.setChannel("Reload")
            
                //Custom sound, badge app icon, alert message?
                let data:NSDictionary = ["alert":"","badge":"1","content-available":"1"]
                push.setData(data as [NSObject : AnyObject])
            
                //Send push notification
                let pushQuery:PFQuery = PFInstallation.query()!
                pushQuery.whereKey("channels",equalTo: "Reload")
                push.setQuery(pushQuery)
                push.setMessage(announcementTitle.text)
            
            
                push.sendPushInBackgroundWithTarget(nil, selector: nil)
            
            }
        
            performSegueWithIdentifier("unwindToHomeScreen", sender: self)
        
        }
        else{
            let errorAlert:UIAlertController = UIAlertController(title: "Textfields Not Filled", message: "Please fill out all textfields before posting an announcement.", preferredStyle: UIAlertControllerStyle.Alert)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(errorAlert,animated: true, completion: nil)
        }
    }
    @IBAction func updateAnnouncementType(sender: AnyObject){
        let buttonClicked = sender as! UIButton
        
        if buttonClicked == generalButton {
            announcementType = 0
            generalText.backgroundColor = UIColor(red: 255.0/255.0, green: 204/255.0, blue: 51/255.0, alpha: 1.0)
            urgentText.backgroundColor = UIColor.clearColor()
            infoText.backgroundColor = UIColor.clearColor()
        } else if buttonClicked == urgentButton {
            announcementType = 1
            generalText.backgroundColor = UIColor.clearColor()
            urgentText.backgroundColor = UIColor(red: 255.0/255.0, green: 204/255.0, blue: 51/255.0, alpha: 1.0)
            infoText.backgroundColor = UIColor.clearColor()
        }
        else if buttonClicked == informativeButton{
            announcementType = 2
            generalText.backgroundColor = UIColor.clearColor()
            urgentText.backgroundColor = UIColor.clearColor()
            infoText.backgroundColor = UIColor(red: 255.0/255.0, green: 204/255.0, blue: 51/255.0, alpha: 1.0)
        }

    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
}
