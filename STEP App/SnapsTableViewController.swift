//
//  SnapsTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 5/29/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class SnapsTableViewController: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    var pictureList:NSMutableArray = NSMutableArray()
    var spinner:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var postSnapBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        refreshControl?.addTarget(self, action: "loadSnapData", forControlEvents:
            UIControlEvents.ValueChanged)
        
        // Configure the activity indicator and start animating
        spinner.activityIndicatorViewStyle = .Gray
        spinner.center = self.view.center
        spinner.hidesWhenStopped = true
        self.parentViewController?.view.addSubview(spinner)
        spinner.startAnimating()
        
        //Load Snaps
        //self.loadSnapData()
        self.loadSnapData()
        
        
        //Self-Sizing
        tableView.estimatedRowHeight = 20.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        
        //No excess
        self.tableView.tableFooterView = UIView(frame:CGRectZero)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
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
        return pictureList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SnapCell", forIndexPath: indexPath) as! SnapImageTableViewCell
        
        
        if (indexPath.row > pictureList.count){
            return cell
        }
        
        // Configure the cell...
        cell.imageImageView.alpha = 0
        cell.captionLabel.alpha = 0
        
        
        let snap:PFObject = self.pictureList.objectAtIndex(indexPath.row) as! PFObject
        
        
        
        let imageFile = snap.objectForKey("image") as! PFFile
        imageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.imageImageView.image = image
                }
            }
        }
        cell.captionLabel.text = snap.objectForKey("caption") as? String
        
        if self.spinner.isAnimating() {
            dispatch_async(dispatch_get_main_queue(), {
                self.spinner.stopAnimating()
            })
        }
        
        UIView.animateWithDuration(0.5, animations: {
            cell.imageImageView.alpha = 1
            cell.captionLabel.alpha = 1
        })
        
        /*
        //Dynamic Cell Height Fix?
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        */
        cell.setNeedsDisplay()

        
        return cell
    }
    
    
    @IBAction func loadSnapData(){
        pictureList.removeAllObjects()
        var findSnaps:PFQuery = PFQuery(className: "SnapImage")
        
        findSnaps.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]?,error:NSError?)-> Void in
            if error == nil{
                for object in objects!{
                    let snap:PFObject = object as! PFObject
                    self.pictureList.addObject(snap)
                }
                let array:NSArray = self.pictureList.reverseObjectEnumerator().allObjects
                self.pictureList = NSMutableArray(array: array)
                self.tableView.reloadData()
            }
            else{
                println("Failed to retrieve snaps from database")
                var errorAlert:UIAlertController = UIAlertController(title: "Failed to connect to the internet", message: "Check network connection and try again.", preferredStyle: UIAlertControllerStyle.Alert)
                errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(errorAlert,animated: true, completion: nil)
            }
        }
        
        //Save to local datastore
        PFObject.pinAllInBackground(pictureList as [AnyObject], block: nil)
        //Remove from local datastore
        PFObject.unpinAllInBackground(pictureList as [AnyObject], block: nil)
        self.refreshControl?.endRefreshing()
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        
        let imageMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let saveAction = UIAlertAction(title: "Save Image", style: UIAlertActionStyle.Default, handler:{ alertAction in
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! SnapImageTableViewCell
            UIImageWriteToSavedPhotosAlbum(cell.imageImageView.image, nil, nil, nil)
            var confirmationAlert:UIAlertController = UIAlertController(title: "Image Saved!", message: "The image has been saved to your photo library!", preferredStyle: UIAlertControllerStyle.Alert)
            confirmationAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(confirmationAlert,animated: true, completion: nil)
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        imageMenu.addAction(saveAction)
        imageMenu.addAction(cancelAction)
        
        self.presentViewController(imageMenu, animated: true, completion: nil)
    }
    
    @IBAction func unwindToSnapsScreen(segue:UIStoryboardSegue) {
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row==self.tableView.indexPathsForVisibleRows()?.first?.row ){
            // Launch walkthrough screens
            let defaults = NSUserDefaults.standardUserDefaults()
            let hasViewedWalkthrough = defaults.boolForKey("hasViewedSnapsPopTip")
            if hasViewedWalkthrough == false {
                defaults.setBool(true, forKey: "hasViewedSnapsPopTip")
                showPopTip(cell,message: "Tap an image to save it.",time:10)
                showPopTip(postSnapBtn,message:"Tap the plus to post a new Snap!",time:10)
            }
        }
    }
    
    func showPopTip(sender: AnyObject, message: String, time:Double) {
        var popTip = SwiftPopTipView(title: "ProTip!", message: message)
        popTip.popColor = UIColor(red: 0/255, green: 102/255, blue: 51/255, alpha: 1)
        popTip.titleColor = UIColor.whiteColor()
        popTip.textColor = UIColor.whiteColor()
        popTip.pointDirection = .Down
        if sender.dynamicType === UIBarButtonItem.self {
            popTip.presentAnimatedPointingAtBarButtonItem(sender as! UIBarButtonItem, autodismissAtTime: time)
        } else {
            popTip.presentAnimatedPointingAtView(sender as! UIView, inView: self.view, autodismissAtTime: time)
        }
    }

}
