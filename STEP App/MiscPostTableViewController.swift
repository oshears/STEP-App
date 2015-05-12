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
