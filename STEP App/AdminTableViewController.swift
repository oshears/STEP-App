//
//  AdminTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 3/9/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class AdminTableViewController: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var logInOut: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Empty back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

        
        //Side Menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //No excess
        self.tableView.tableFooterView = UIView(frame:CGRectZero)


        
    }
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil{
            logInOut.text = "Logout of \(PFUser.currentUser()!.username!)"
        }
        else{
            logInOut.text = "Admin Login"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row == 0{
            if PFUser.currentUser() != nil{
                PFUser.logOut()
                var errorAlert:UIAlertController = UIAlertController(title: "Logout Successful!", message: "You have been logged out.", preferredStyle: UIAlertControllerStyle.Alert)
                errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(errorAlert,animated: true, completion: nil)
            }
            else{
                self.showLogin()
            }
            if PFUser.currentUser() != nil{
                logInOut.text = "Logout of \(PFUser.currentUser()!.username!)"
            }
            else{
                logInOut.text = "Admin Login"
            }
        }
        else if (indexPath.row==2){
            if (PFUser.currentUser()==nil){
                showLogin()
            }
            else{
                var messageAlert:UIAlertController = UIAlertController(title: "New Push Notification", message: "Enter your message", preferredStyle: UIAlertControllerStyle.Alert)
                
                messageAlert.addTextFieldWithConfigurationHandler{
                    (textfield:UITextField!) -> Void in
                    
                    textfield.placeholder = "Your message ..."
                    
                }
                
                messageAlert.addAction(UIAlertAction(title: "Send", style: UIAlertActionStyle.Default, handler: {
                    (alertAction:UIAlertAction!) -> Void in
                    var push:PFPush = PFPush()
                    //push.setChannel("Reload")
                    //Custom sound, badge app icon, alert message?
                    var data:NSDictionary = ["alert":"","badge":"1","content-available":"1","sound":"Glass.aiff"]
                    push.setData(data as [NSObject : AnyObject])
                    //Send push notification
                    var pushQuery:PFQuery = PFInstallation.query()!
                    pushQuery.whereKey("channels",equalTo: "Reload")
                    push.setQuery(pushQuery)
                    
                    let messageTextField:UITextField = messageAlert.textFields?.first as! UITextField
                    push.setMessage(messageTextField.text)
                    push.sendPushInBackgroundWithTarget(nil, selector: nil)
                    
                }))
                
                messageAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(messageAlert, animated: true, completion: nil)
            }
        }
       
    }
    
    

    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "postGeneralAnnouncement"{
            if PFUser.currentUser() != nil{
                println("Transition authorized")
                return true
            }
            else{
                println("Login requested")
                self.showLogin()
                return false
            }
        }
        return true
    }
    
    func showLogin(){
        var didLogin:Bool = false
        println("Proceeding with attempt...")
        var loginAlert:UIAlertController = UIAlertController(title: "Admin Login", message: "Please login to proceed", preferredStyle: UIAlertControllerStyle.Alert)
        loginAlert.addTextFieldWithConfigurationHandler({
            textField in
            textField.placeholder = "Admin username"
            
        })
        loginAlert.addTextFieldWithConfigurationHandler({
            textField in
            textField.placeholder = "Admin password"
            textField.secureTextEntry = true
            
        })
        
        loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
            alertAction in
            let textFields:NSArray = loginAlert.textFields as NSArray!
            let usernameTextfield:UITextField = textFields.objectAtIndex(0) as! UITextField
            let passwordTextField:UITextField = textFields.objectAtIndex(1) as! UITextField
        
            PFUser.logInWithUsernameInBackground(usernameTextfield.text!, password: passwordTextField.text!){
                (user:PFUser?,error:NSError?)->Void in
                println("User info exits?: \(user)")
                if (user != nil){
                    println("login successful")
                    
                    //What does this do?
                    var installation:PFInstallation = PFInstallation.currentInstallation()
                    installation.addUniqueObject("Reload", forKey: "channels")
                    installation["user"] = PFUser.currentUser()
                    installation.saveInBackgroundWithTarget(nil, selector: nil)
                    didLogin = true
                }
                else{
                    println("login failed")
                }
                if !(didLogin){
                    var errorAlert:UIAlertController = UIAlertController(title: "Incorrect Login Credentials!", message: "Only registered admins may access this tab...", preferredStyle: UIAlertControllerStyle.Alert)
                    errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                    self.presentViewController(errorAlert,animated: true, completion: nil)
                    
                }
                else{
                    var loginAlert:UIAlertController = UIAlertController(title: "Hello \(PFUser.currentUser()!.username!)", message:"Successfully logged in as \(PFUser.currentUser()!.username!)",preferredStyle: .Alert)
                    loginAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                    self.presentViewController(loginAlert,animated: true, completion: nil)
                    
                    if PFUser.currentUser() != nil{
                        self.logInOut.text = "Logout out of \(PFUser.currentUser()!.username!)"
                    }
                    else{
                        self.logInOut.text = "Admin Login"
                    }
                    
                }
            }
        }))
        
        
        self.presentViewController(loginAlert,animated: true, completion: nil)
        
        
        
    }
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
        
    }
    
}
