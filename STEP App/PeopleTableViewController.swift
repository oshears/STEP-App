//
//  PeopleTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 3/10/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class PeopleTableViewController: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var people:[Person] =
    [
        Person(name:"Felicia Baez", bio:"Hey STEP family! My name is Felicia Baez and I am a junior at GMU from Richmond, Virginia. My major is Integrative Studies with a concentration in International Studies and I have a minor in Women and Gender Studies. On campus I am involved in a student organization called Chase Dreams Not Boys, I am a Peer Health Educator with the Wellness, Alcohol, Violence, Education, and Services office, and starting in the fall semester I will be a Resident Advisor. One interesting fact about me is that I have studied abroad in Granada, Spain! I am so excited to meet you all and I know we are going to have a great summer!", image:"felicia", role:"Mentor"),
        Person(name:"Ebadullah Ebadi", bio:"Hi there! My name is Ebadullah Ebadi and I am a senior at George Mason University majoring in Government & International Politics with a minor in Communication! I was a part of STEP 2011 cohort! Throughout my time here at Mason, I have been involved with the Afghan Student Union, the Muslim Student Association, Pi Sigma Alpha Political Science Honor Society, and various other activities! I am the Outreach Coordinator for ODIME and a Head Resident Advisor for Housing & Residence Life. Some of my hobbies include watching movies, playing sports, spending time with loved ones, and playing music with my band, Leftist! I hope you all enjoy STEP and the memories you will make with one another during this time and your next few years here. I am excited to be working with you all!", image:"ebi", role:"Mentor"),
        Person(name:"Vivi Luong", bio:"Hi all! My name is Vivi Luong! I’m a senior at GMU, majoring in Communication and minoring in Sports Communication. I am an Events Manager for GMU’s Student Involvement office, a Resident Advisor and a Peer Advisor! I was born in Ho Chi Minh City, Vietnam and grew up in Los Angeles, California! I LOVE TRAVELING! I would love to visit as many countries and it is my dream to visit some of the world’s best beaches. I like to workout during my free time, especially when I get to go to a fitness class and has lots of DANCING! However during MOST of my free time I binge watch Netflix and YouTube videos! I’m looking forward to spending this summer with the STEP program because it was on my GMU Bucket List to become a mentor, so I am VERY EXCITED!!! It will be plenty of fun getting to know you all and I cannot wait!", image:"vivi", role:"Mentor"),
        Person(name:"Rodrigo Velasquez", bio:"Hello STEP 2015 scholars! My name is Rodrigo Velasquez and I'm really excited to be a STEP mentor this summer! I'm a rising Senior majoring in Communication with a concentration in Public Relations and minoring in Women and Gender Studies. This fall I'll also be starting an Accelerated Masters program in Women and Gender Studies with the hope of focusing my research on undocumented women. I was born in Cochabamba, Bolivia, love short walks to the fridge, and occasionally I can be found at a protest somewhere in the area. In the past, I've served as a Leadership Consultant, Resident Advisor, Teaching Assistant for LGBTQ Studies, Delegate for the Global Engagement Summit, and a few other things on and off campus. Next year I'm excited to be the President of Mason DREAMers and continue my advocacy as an organizer with GMU Student Power, the Virginia Student Power Network, and Students Against Israeli Apartheid! I was also in STEP during the summer of 2012! I’m excited to go through this experience with you!", image:"rodrigo", role:"Mentor")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //Side Menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.people.count
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PersonCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PeopleTableViewCell
        
        // Configure the cell...
        let person = people[indexPath.row]
        cell.nameLabel.text = person.name
        cell.profileImge.image = UIImage(named:person.image)
        cell.occupationLabel.text = person.role
        
        // Circular image
        cell.profileImge.layer.cornerRadius = cell.profileImge.frame.size.width / 2
        cell.profileImge.clipsToBounds = true
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "detailedPerson" {
            if let row = tableView.indexPathForSelectedRow()?.row {
                
                //var retrievedAnnouncement:PFObject = announcementList[row] as PFObject
                let announcement = self.people[row]
                /*var title:String = announcement.objectForKey("title") as! String
                var content:String = announcement.objectForKey("content") as! String
                
                var dataFormatter:NSDateFormatter = NSDateFormatter()
                dataFormatter.dateFormat = "yyy-MM-dd HH:mm"
                var postDate:String = dataFormatter.stringFromDate(announcement.createdAt!)*/
                
                
                let destinationController = segue.destinationViewController as! DetailPersonTableViewController
                
                
                destinationController.person = self.people[row]
                
                destinationController.hidesBottomBarWhenPushed = true
            }
        }
        
    }
    @IBAction func unwindToPeopleScreen(segue:UIStoryboardSegue) {
        
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
