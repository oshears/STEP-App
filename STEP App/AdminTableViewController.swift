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
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
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
                let errorAlert:UIAlertController = UIAlertController(title: "Logout Successful!", message: "You have been logged out.", preferredStyle: UIAlertControllerStyle.Alert)
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
                let messageAlert:UIAlertController = UIAlertController(title: "New Push Notification", message: "Enter your message", preferredStyle: UIAlertControllerStyle.Alert)
                
                messageAlert.addTextFieldWithConfigurationHandler{
                    (textfield:UITextField!) -> Void in
                    
                    textfield.placeholder = "Your message ..."
                    
                }
                
                messageAlert.addAction(UIAlertAction(title: "Send", style: UIAlertActionStyle.Default, handler: {
                    (alertAction:UIAlertAction) -> Void in
                    let push:PFPush = PFPush()
                    //push.setChannel("Reload")
                    //Custom sound, badge app icon, alert message?
                    let data:NSDictionary = ["alert":"","badge":"1","content-available":"1","sound":"default"]
                    push.setData(data as [NSObject : AnyObject])
                    //Send push notification
                    let pushQuery:PFQuery = PFInstallation.query()!
                    pushQuery.whereKey("channels",equalTo: "Reload")
                    push.setQuery(pushQuery)
                    
                    let messageTextField:UITextField = (messageAlert.textFields?.first!)! as UITextField
                    push.setMessage(messageTextField.text)
                    push.sendPushInBackgroundWithTarget(nil, selector: nil)
                    
                }))
                
                messageAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(messageAlert, animated: true, completion: nil)
            }
        }
        else if (indexPath.row==3){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(false, forKey: "hasViewedAnnouncementPopTip")
            defaults.setBool(false, forKey: "hasViewedMiscAnnouncementPopTip")
            defaults.setBool(false, forKey: "hasViewedCalendarPopTip")
            defaults.setBool(false, forKey: "hasViewedPeoplePopTip")
            defaults.setBool(false, forKey: "hasViewedHoursPopTip")
            defaults.setBool(false, forKey: "hasViewedFaqsPopTip")
            defaults.setBool(false, forKey: "hasViewedSnapsPopTip")
            
            let messageAlert:UIAlertController = UIAlertController(title: "PopTips Reset!", message: "All PopTips have been reset.", preferredStyle: UIAlertControllerStyle.Alert)
            messageAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(messageAlert, animated: true, completion: nil)

        }
       
    }
    
    

    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "postGeneralAnnouncement"{
            if PFUser.currentUser() != nil{
                print("Transition authorized")
                return true
            }
            else{
                print("Login requested")
                self.showLogin()
                return false
            }
        }
        return true
    }
    
    func showLogin(){
        var didLogin:Bool = false
        print("Proceeding with attempt...")
        let loginAlert:UIAlertController = UIAlertController(title: "Admin Login", message: "Please login to proceed", preferredStyle: UIAlertControllerStyle.Alert)
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
                print("User info exits?: \(user)")
                if (user != nil){
                    print("login successful")
                    
                    //What does this do?
                    let installation:PFInstallation = PFInstallation.currentInstallation()
                    installation.addUniqueObject("Reload", forKey: "channels")
                    installation["user"] = PFUser.currentUser()
                    installation.saveInBackgroundWithTarget(nil, selector: nil)
                    didLogin = true
                }
                else{
                    print("login failed")
                }
                if !(didLogin){
                    let errorAlert:UIAlertController = UIAlertController(title: "Incorrect Login Credentials!", message: "Only registered admins may access this tab...", preferredStyle: UIAlertControllerStyle.Alert)
                    errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                    self.presentViewController(errorAlert,animated: true, completion: nil)
                    
                }
                else{
                    let loginAlert:UIAlertController = UIAlertController(title: "Hello \(PFUser.currentUser()!.username!)", message:"Successfully logged in as \(PFUser.currentUser()!.username!)",preferredStyle: .Alert)
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
