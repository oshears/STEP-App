//
//  AddFAQTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 5/29/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class AddFAQTableViewController: UITableViewController, UITextViewDelegate {

    @IBOutlet weak var faqTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        faqTextView.layer.borderColor = UIColor.blackColor().CGColor
        faqTextView.layer.borderWidth = 0.5
        faqTextView.layer.cornerRadius = 5
        faqTextView.delegate = self
        faqTextView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func postQuestion(){
        let notBlank = faqTextView.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != ""
        if notBlank{
            let faq:PFObject = PFObject(className: "FAQ")
            faq["question"] = faqTextView.text
            
            faq.saveInBackgroundWithTarget(nil, selector: nil)
            //performSegueWithIdentifier("unwindToFaqsScreen", sender: self)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else{
            let errorAlert:UIAlertController = UIAlertController(title: "Textfields Not Filled", message: "Please fill out all textfields before posting a FAQ.", preferredStyle: UIAlertControllerStyle.Alert)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(errorAlert,animated: true, completion: nil)
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    


}
