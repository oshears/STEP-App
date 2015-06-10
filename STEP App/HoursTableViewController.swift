//
//  HoursTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 3/19/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class HoursTableViewController: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var eateries:[Eatery] =
    [
        Eatery(title:"Chick fil A",weekHours:"Monday - Friday: 10:00am - 3:00pm",weekendHours:"Saturday - Sunday: Closed",image:"chickfila",desc:"Chicken sandwiches, chicken strips and chicken nuggets served with waffle fries and fresh squeezed lemonade.",[nil,10,10,10,10,10,nil],[nil,15,15,15,15,15,nil]),
        
        Eatery(title:"Rathskeller",weekHours:"Monday - Friday: 11:00am - 2:00pm",weekendHours:"Saturday - Sunday: Closed",image:"rathsk",desc:"Relax with friends, enjoy our \"fan\"tastic menu and catch up on all the games at this sports bar with a touch of Mason history.",[nil,11,11,11,11,11,nil],[nil,14,14,14,14,14,nil]),
        
        Eatery(title:"Burger King",weekHours:"Monday - Friday: 11:00am - 3:00pm",weekendHours:"Saturday - Sunday: Closed",image:"burgerking",desc:"Burger King, in the Johnson Center, is a proven hit on the Mason campus. Whether breakfast, lunch or dinner, the Mason community can always depend on Burger King for the high quality and value for which this national brand is known.",[nil,11,11,11,11,11,nil],[nil,15,15,15,15,15,nil]),
        
        Eatery(title:"Freshen's and Express (General Store)",weekHours:"Monday: 11:00am - 3:00pm, Tuesday - Friday: 8:30am - 6:00pm",weekendHours:"Saturday - Sunday: 10:00am - 4:00pm",image:"convenience",desc:"The Express General Store and Freshns is at home in the Johnson Center adjacent to the Food Court! With lots of retail shelf, cooler and freezer space, packaged sandwiches and fresh salads, Mason students love the Express!",[10,11,8.5,8.5,8.5,8.5,10],[16,15,18,18,18,18,16]),
        
        Eatery(title:"IndAroma",weekHours:"Monday - Friday: 11:00am - 7:00pm",weekendHours:"Saturday - Sunday: 11:00am - 6:00pm",image:"indaroma",desc:"Sangam Restaurant blends fresh local ingredients with bold Indian sauces and spices, always with a focus on North & South Indian dishes. Each day you’ll find a tantalizing range of appetizers, entrées, fresh Sangam specialty dishes and desserts. Halal vendor.",[11,11,11,11,11,11,11],[18,19,19,19,19,19,18]),
        
        Eatery(title:"Jorge's",weekHours:"Monday - Friday: 11:00am - 3:00pm",weekendHours:"Saturday: 11:00am - 3:00pm, Sunday: Closed",image:"jorges",desc:"New to Mason Dining, Jorge’s features Tex Mex cuisine made fresh daily.",[nil,11,11,11,11,11,11],[nil,15,15,15,15,15,15]),
        
        Eatery(title:"Panera Bread",weekHours:"Monday - Friday: 7:00am - 8:00pm",weekendHours:"Saturday - Sunday: 7:00am - 7:00pm",image:"panera",desc:"N/A",[7,7,7,7,7,7,7],[19,20,20,20,20,20,19]),
        
        Eatery(title:"Red, Hot & Blue",weekHours:"Monday - Friday: 11:00am - 7:00pm",weekendHours:"Saturday - Sunday: 11:00am - 6:00pm",image:"redhotblue",desc:"The well-known barbecue joint is located in the Johnson Center. Featuring pulled pork sandwiches and a variety of barbecue favorites!",[11,11,11,11,11,11,11],[18,19,19,19,19,19,18]),
       
        Eatery(title:"Starbucks",weekHours:"Monday - Thursday: 7:30am - 5:00pm, Friday: 7:30am - 3:30pm",weekendHours:"Saturday - Sunday: Closed",image:"starbucks",desc:"Check out Starbucks in the JC on the bottom level.",[nil,7.5,7.5,7.5,7.5,7.5,nil],[nil,17,17,17,17,15.5,nil]),
        
        Eatery(title:"Einstein's Bagels",weekHours:"Monday - Friday: 7:00am - 3:30pm",weekendHours:"Saturday - Sunday: Closed",image:"einstein",desc:"Grab a bagel and cup of coffee on your way to class from either of these convenient locations.",[nil,7,7,7,7,7,nil],[nil,15.5,15.5,15.5,15.5,15.5,nil]),
        
        Eatery(title:"Manhattan Pizza",weekHours:"Monday - Friday: 11:00am - 7:00pm",weekendHours:"Saturday: 11:00am - 4:00pm, Sunday: Closed",image:"manhattan",desc:"New York style pizza along with wings, subs, calzones, garlic knots, and French fries served right here on campus!",[nil,11,11,11,11,11,11],[nil,19,19,19,19,19,16]),
        
        Eatery(title:"Panda",weekHours:"Monday - Friday: 10:30am - 3:30pm",weekendHours:"Saturday - Sunday: Closed",image:"panda",desc:"Panda Express is America’s favorite Chinese restaurant, serving fresh and fast Chinese food.",[nil,10.5,10.5,10.5,10.5,10.5,nil],[nil,15.5,15.5,15.5,15.5,15.5,nil]),
        
        Eatery(title:"Globe",weekHours:"Monday - Friday: 7:00am - 6:00pm",weekendHours:"Saturday - Sunday: 10:30am - 6:00pm",image:"globe",desc:"N/A",[10.5,7,7,7,7,7,10.5],[18,18,18,18,18,18,18]),
        
        Eatery(title:"Subway",weekHours:"Monday - Friday: 11:00am - 3:00pm",weekendHours:"Saturday - Sunday: Closed",image:"subway",desc:"Recently opened on campus Spring 2012, this Subway restaurant features many of the famous foot-long subs and sandwiches that you love! This establishment offers a full-service menu and is located in Rogers (residence hall).",[nil,11,11,11,11,11,nil],[nil,15,15,15,15,15,nil])
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
        
        // Self Sizing Cells
        self.tableView.estimatedRowHeight = 123.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;

        
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.eateries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "HoursCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! HoursTableViewCell
        
        // Configure the cell...
        let eatery = eateries[indexPath.row]
        cell.eateryTitle.text = eatery.title
        cell.eateryImage.image = UIImage(named:eatery.image)
        cell.eateryWeekHours.text = eatery.weekHours
        cell.eateryWeekendHours.text = eatery.weekendHours
        
        // Circular image
        cell.eateryImage.layer.cornerRadius = cell.eateryImage.frame.size.width / 2
        cell.eateryImage.clipsToBounds = true
        
        /*
        //Dynamic Cell Height Fix?
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        */
        //cell.setNeedsDisplay()
        
        
        return cell
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "detailedHours" {
            if let row = tableView.indexPathForSelectedRow()?.row {
                let destinationController = segue.destinationViewController as! DetailedHoursTableViewController
                destinationController.eatery = self.eateries[row]                
                destinationController.hidesBottomBarWhenPushed = true
            }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        tableView.reloadData()
        
    }

    

   
}
