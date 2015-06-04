//
//  PostSnapTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 6/4/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class PostSnapTableViewController: UITableViewController, UITextViewDelegate {

    @IBOutlet weak var snapImageView: UIImageView!
   
    
    @IBOutlet weak var snapCaptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        snapCaptionTextView.layer.borderColor = UIColor.blackColor().CGColor
        snapCaptionTextView.layer.borderWidth = 0.5
        snapCaptionTextView.layer.cornerRadius = 5
        snapCaptionTextView.delegate = self
        snapCaptionTextView.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postQuestion(){
        var notBlank = snapCaptionTextView.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != ""
        if notBlank{
            var faq:PFObject = PFObject(className: "SnapImage")
            faq["caption"] = snapCaptionTextView.text
            
            faq.saveInBackgroundWithTarget(nil, selector: nil)
            //performSegueWithIdentifier("unwindToFaqsScreen", sender: self)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else{
            var errorAlert:UIAlertController = UIAlertController(title: "Textfields Not Filled", message: "Please fill out all textfields before posting a Snap.", preferredStyle: UIAlertControllerStyle.Alert)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(errorAlert,animated: true, completion: nil)
        }
    }
}
