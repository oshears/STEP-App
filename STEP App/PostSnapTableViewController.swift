//
//  PostSnapTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 6/4/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class PostSnapTableViewController: UITableViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var snapImageView: UIImageView!
   
    
    @IBOutlet weak var snapCaptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snapCaptionTextView.layer.borderColor = UIColor.blackColor().CGColor
        snapCaptionTextView.layer.borderWidth = 0.5
        snapCaptionTextView.layer.cornerRadius = 5
        snapCaptionTextView.delegate = self
        snapCaptionTextView.returnKeyType = .Done
        
        
        //No excess
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postQuestion(){
        var notBlank = snapCaptionTextView.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != ""
        if notBlank{
            var snap:PFObject = PFObject(className: "SnapImage")
            snap["caption"] = snapCaptionTextView.text
            
            let imageData = UIImagePNGRepresentation(snapImageView.image)
            let imageFile = PFFile(name:"snapimage.png", data:imageData)
            snap["image"] = imageFile
            
            snap.saveInBackgroundWithTarget(nil, selector: nil)
            //performSegueWithIdentifier("unwindToFaqsScreen", sender: self)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else{
            var errorAlert:UIAlertController = UIAlertController(title: "Textfields Not Filled", message: "Please fill out all textfields before posting a Snap.", preferredStyle: UIAlertControllerStyle.Alert)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(errorAlert,animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.endEditing(true)
        return true
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Selected the image
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.delegate = self
                imagePicker.sourceType = .PhotoLibrary
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    //Image Picker Controller
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        snapImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        snapImageView.contentMode = UIViewContentMode.ScaleAspectFit
        snapImageView.clipsToBounds = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    

}
