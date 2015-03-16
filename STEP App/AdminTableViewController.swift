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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Empty back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

        
        //Side Menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        
    }
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil{
            logInOut.text = "Logout of \(PFUser.currentUser().username)"
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
        }
        if PFUser.currentUser() != nil{
            logInOut.text = "Logout of \(PFUser.currentUser().username)"
        }
        else{
            logInOut.text = "Admin Login"
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
            let usernameTextfield:UITextField = textFields.objectAtIndex(0) as UITextField
            let passwordTextField:UITextField = textFields.objectAtIndex(1) as UITextField
            PFUser.logInWithUsernameInBackground(usernameTextfield.text, password: passwordTextField.text){
                (user:PFUser!,error:NSError!)->Void in
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
                    var loginAlert:UIAlertController = UIAlertController(title: "Hello \(PFUser.currentUser().username)", message:"Successfully logged in as \(PFUser.currentUser().username)",preferredStyle: .Alert)
                    loginAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                    self.presentViewController(loginAlert,animated: true, completion: nil)
                    
                    if PFUser.currentUser() != nil{
                        self.logInOut.text = "Logout out of \(PFUser.currentUser().username)"
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
