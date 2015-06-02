//
//  FAQTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 5/29/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class FAQTableViewController: UITableViewController {
    
    var faqList:NSMutableArray = NSMutableArray()
    var spinner:UIActivityIndicatorView = UIActivityIndicatorView()

    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        //Load FAQs
        self.loadFAQData()
        
        //Side Menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //Self-Sizing
        tableView.estimatedRowHeight = 36.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        
        // Pull To Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor(red: 220/255, green: 222/255, blue: 223/255, alpha: 1)
        refreshControl?.tintColor = UIColor.grayColor()
        refreshControl?.addTarget(self, action: "loadFAQData", forControlEvents:
            UIControlEvents.ValueChanged)
        
        
        // Configure the activity indicator and start animating
        spinner.activityIndicatorViewStyle = .Gray
        spinner.center = self.view.center
        spinner.hidesWhenStopped = true
        self.parentViewController?.view.addSubview(spinner)
        spinner.startAnimating()
        
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
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
        return faqList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FAQCell", forIndexPath: indexPath) as! FAQTableViewCell

        if (indexPath.row > faqList.count){
            return cell
        }
        
        // Configure the cell...
        cell.questionLabel.alpha = 0
        
        
        
        let faq:PFObject = self.faqList.objectAtIndex(indexPath.row) as! PFObject
        
        
        
        cell.questionLabel.text = faq.objectForKey("question") as? String

        if self.spinner.isAnimating() {
            dispatch_async(dispatch_get_main_queue(), {
                self.spinner.stopAnimating()
            })
        }

        UIView.animateWithDuration(0.5, animations: {
            cell.questionLabel.alpha = 1
        })
        
        /*
        //Dynamic Cell Height Fix?
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        */
        
        cell.setNeedsDisplay()
        return cell
    }
    
    @IBAction func loadFAQData(){
        faqList.removeAllObjects()
        var findFaqs:PFQuery = PFQuery(className: "FAQ")
        
        findFaqs.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]?,error:NSError?)-> Void in
            if error == nil{
                for object in objects!{
                    let faq:PFObject = object as! PFObject
                    self.faqList.addObject(faq)
                }
                let array:NSArray = self.faqList.reverseObjectEnumerator().allObjects
                self.faqList = NSMutableArray(array: array)
                self.tableView.reloadData()
            }
            else{
                println("Failed to retrieve faqs from database")
                var errorAlert:UIAlertController = UIAlertController(title: "Failed to connect to the internet", message: "Check network connection and try again.", preferredStyle: UIAlertControllerStyle.Alert)
                errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(errorAlert,animated: true, completion: nil)
            }
        }
                
        //Save to local datastore
        PFObject.pinAllInBackground(faqList as [AnyObject], block: nil)
        //Remove from local datastore
        PFObject.unpinAllInBackground(faqList as [AnyObject], block: nil)
        self.refreshControl?.endRefreshing()
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "detailedQuestion" {
            if let row = tableView.indexPathForSelectedRow()?.row {
                
                let faq:PFObject = self.faqList.objectAtIndex(row) as! PFObject
                var question:String = faq.objectForKey("question") as! String
                var answer:String = (faq.objectForKey("answer")==nil) ? "" : faq.objectForKey("answer") as! String
                let destinationController = segue.destinationViewController as! DetailFAQTableViewController
                
                destinationController.faq = FAQ(question: question, answer: answer)
                
            }
        }
    }
    
    @IBAction func unwindToFaqsScreen(segue:UIStoryboardSegue) {
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
