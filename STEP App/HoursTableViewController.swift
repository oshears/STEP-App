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
        Eatery(title:"Chick fil A",weekHours:"Monday - Friday: 10:00am - 3:00pm",weekendHours:"Saturday - Sunday: Closed",image:"chickfila",desc:"Chicken sandwiches, chicken strips and chicken nuggets served with waffle fries and fresh squeezed lemonade.",openTimes: [-1,10,10,10,10,10,-1],closeTimes: [-1,15,15,15,15,15,-1]),
        
        Eatery(title:"Rathskeller",weekHours:"Monday - Friday: 11:00am - 3:00pm",weekendHours:"Saturday - Sunday: Closed",image:"rathsk",desc:"Relax with friends, enjoy our \"fan\"tastic menu and catch up on all the games at this sports bar with a touch of Mason history.",openTimes: [-1,11,11,11,11,11,-1],closeTimes: [-1,15,15,15,15,15,-1]),
        
        Eatery(title:"Burger King",weekHours:"Monday - Friday: 8:00am - 3:00pm",weekendHours:"Saturday - Sunday: Closed",image:"burgerking",desc:"Burger King, in the Johnson Center, is a proven hit on the Mason campus. Whether breakfast, lunch or dinner, the Mason community can always depend on Burger King for the high quality and value for which this national brand is known.",openTimes: [-1,8,8,8,8,8,-1],closeTimes: [-1,15,15,15,15,15,-1]),
        
        Eatery(title:"Freshen's",weekHours:"Monday - Friday: 11:00am - 2:00pm",weekendHours:"Saturday - Sunday: Closed",image:"convenience",desc:"The Express General Store and Freshns is at home in the Johnson Center adjacent to the Food Court! With lots of retail shelf, cooler and freezer space, packaged sandwiches and fresh salads, Mason students love the Express!",openTimes: [-1,11,11,11,11,11,-1],closeTimes: [-1,14,14,14,14,14,-1]),
        
        Eatery(title:"Express (General Store)",weekHours:"Monday: 11:00am - 3:00pm, Tuesday - Friday: 8:30am - 6:00pm",weekendHours:"Saturday - Sunday: 10:00am - 4:00pm",image:"convenience",desc:"The Express General Store and Freshns is at home in the Johnson Center adjacent to the Food Court! With lots of retail shelf, cooler and freezer space, packaged sandwiches and fresh salads, Mason students love the Express!",openTimes: [10,8.5,8.5,8.5,8.5,8.5,10],closeTimes: [16,18,18,18,18,18,16]),
        
        Eatery(title:"IndAroma",weekHours:"Monday - Friday: 11:00am - 7:00pm",weekendHours:"Saturday - Sunday: 11:00am - 6:00pm",image:"indaroma",desc:"Sangam Restaurant blends fresh local ingredients with bold Indian sauces and spices, always with a focus on North & South Indian dishes. Each day you’ll find a tantalizing range of appetizers, entrées, fresh Sangam specialty dishes and desserts. Halal vendor.",openTimes: [11,11,11,11,11,11,11],closeTimes: [18,19,19,19,19,19,18]),
        
        Eatery(title:"Jorge's",weekHours:"Monday - Friday: 11:00am - 3:00pm",weekendHours:"Saturday - Sunday: 11:00am - 3:00pm, Sunday: Closed",image:"jorges",desc:"New to Mason Dining, Jorge’s features Tex Mex cuisine made fresh daily.",openTimes: [-1,11,11,11,11,11,-1],closeTimes: [-1,15,15,15,15,15,-1]),
        
        Eatery(title:"Red, Hot & Blue",weekHours:"Monday - Friday: 11:00am - 7:00pm",weekendHours:"Saturday - Sunday: 11:00am - 6:00pm",image:"redhotblue",desc:"The well-known barbecue joint is located in the Johnson Center. Featuring pulled pork sandwiches and a variety of barbecue favorites!",openTimes: [11,11,11,11,11,11,11],closeTimes: [18,19,19,19,19,19,18]),
       
        Eatery(title:"Starbucks (JC)",weekHours:"Monday - Thursday: 7:30am - 5:00pm, Friday: 7:30am - 3:30pm",weekendHours:"Saturday - Sunday: Closed",image:"starbucks",desc:"Check out Starbucks in the JC on the bottom level.",openTimes: [-1,7.5,7.5,7.5,7.5,7.5,-1],closeTimes: [-1,17,17,17,17,17,-1]),
        
        Eatery(title:"Starbucks (Northern Neck)",weekHours:"Monday - Friday: 7:30am - 5:00pm",weekendHours:"Saturday - Sunday: Closed",image:"starbucks",desc:"Check out Starbucks at the bottom level of Northern Neck.",openTimes: [-1,7.5,7.5,7.5,7.5,7.5,-1],closeTimes: [-1,15.5,15.5,15.5,15.5,15.5,-1]),
        
        Eatery(title:"Einstein's Bagels (Merten Hall)",weekHours:"Monday - Friday: 7:00am - 3:30pm",weekendHours:"Saturday - Sunday: Closed",image:"einstein",desc:"Grab a bagel and cup of coffee on your way to class!",openTimes: [-1,7.5,7.5,7.5,7.5,7.5,-1],closeTimes: [-1,15.5,15.5,15.5,15.5,15.5,-1]),
        
        Eatery(title:"Paisano's Pizza (Delivery)",weekHours:"Sunday - Thursday: 11:00am - 11:00pm",weekendHours:"Friday - Saturday: 11:00am - 12:00am, Sunday: Closed",image:"paisanos",desc:"Paisano’s offers true gourmet pizza, using the finest, most expensive ingredients available. Taste the difference for yourself, and find out why Paisano’s has become the top choice of selective pizza-cravers across the Northern Virginia area!",openTimes: [11,11,11,11,11,11,11],closeTimes: [23,23,23,23,23,23.5,23.5]),
        
        
        
        Eatery(title:"Globe",weekHours:"Monday - Friday: Breakfast: 8:00am - 10:00am, Lunch: 11:00am - 2:30pm, Dinner: 4:30pm - 7:00pm",weekendHours:"Saturday - Sunday: Breakfast: 10:30am - 2:30pm, Dinner: 4:30pm - 7:00pm",image:"globe",desc:"N/A",openTimes: [8,8,8,8,8,8,8],closeTimes: [19,19,19,19,19,19,19]),
        
        Eatery(title:"Erbert & Gerbert's",weekHours:"Monday - Friday: 11:00am - 3:00pm",weekendHours:"Saturday - Sunday: Closed",image:"erbert",desc:"A sandwich shop dedicated to serving better, more flavorful sandwiches than anyone else in the universe.",openTimes: [-1,11,11,11,11,11,-1],closeTimes: [-1,15,15,15,15,15,-1]),
        Eatery(title:"Star Ginger",weekHours:"Monday - Friday: 11:00am - 3:00pm",weekendHours:"Saturday - Sunday: Closed",image:"ginger",desc:"Pan-Asian favorites and freshly prepared sushi right on campus.",openTimes: [-1,11,11,11,11,11,-1],closeTimes: [-1,15,15,15,15,15,-1]),
        
        Eatery(title:"Wing Zone",weekHours:"Monday - Friday: 11:00am - 3:00pm",weekendHours:"Saturday - Sunday: Closed",image:"wingzone",desc:"Our distinctive flavors are the product of 20 years of research development and award winning acclaim. They’re also a little bit crazy and fun! That’s why the National Buffalo Wing Festival honors Wing Zone year after year for our amazing flavors. Our flavor focus is bringing innovation to the limited dine-in/takeout, food court, grill & tap, and drive-thru markets. We’ve also been named by Inc. Magazine, Success Magazine and Entrepreneur Magazine as one of the industry’s fastest growing franchise concepts. The company has been featured on the Food Network, ESPN, CNBC and Fox Business News.",openTimes: [-1,11,11,11,11,11,-1],closeTimes: [-1,18,18,18,18,18,-1]),
        
        Eatery(title:"Panera Bread",weekHours:"Monday - Friday: 7:00am - 9:00pm",weekendHours:"Saturday - Sunday: 8:00am - 9:00pm",image:"panera",desc:"N/A",openTimes: [8,7,7,7,7,7,8],closeTimes: [21,21,21,21,21,21,21]),
        
        Eatery(title:"Panda Express",weekHours:"Monday - Friday: 10:30am - 3:30pm",weekendHours:"Saturday - Sunday: Closed",image:"panda",desc:"Panda Express is America’s favorite Chinese restaurant, serving fresh and fast Chinese food.",openTimes: [-1,10.5,10.5,10.5,10.5,10.5,-1],closeTimes: [-1,15.5,15.5,15.5,15.5,15.5,-1]),
        Eatery(title:"Subway",weekHours:"Monday - Friday: 11:00am - 3:00pm",weekendHours:"Saturday - Sunday: Closed",image:"subway",desc:"Recently opened on campus Spring 2012, this Subway restaurant features many of the famous foot-long subs and sandwiches that you love! This establishment offers a full-service menu and is located in Rogers (residence hall).",openTimes: [-1,11,11,11,11,11,-1],closeTimes: [-1,15,15,15,15,15,-1])
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
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
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
        
        if (eatery.isClosed){
            cell.containerView.backgroundColor=UIColor.grayColor()
        }
        else{
            cell.containerView.backgroundColor=UIColor.whiteColor()
        }
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
            if let row = tableView.indexPathForSelectedRow?.row {
                let destinationController = segue.destinationViewController as! DetailedHoursTableViewController
                destinationController.eatery = self.eateries[row]                
                destinationController.hidesBottomBarWhenPushed = true
            }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        tableView.reloadData()
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row==self.tableView.indexPathsForVisibleRows?.first?.row ){
            // Launch walkthrough screens
            let defaults = NSUserDefaults.standardUserDefaults()
            let hasViewedWalkthrough = defaults.boolForKey("hasViewedHoursPopTip")
            
            if hasViewedWalkthrough == false {
                defaults.setBool(true, forKey: "hasViewedHoursPopTip")
                showPopTip(cell,message: "Tap a restaurant to view detailed information. Restaurants with a gray background are closed at the current time.")
            }
        }
    }
    
    func showPopTip(sender: AnyObject, message: String) {
        let popTip = SwiftPopTipView(title: "ProTip!", message: message)
        popTip.popColor = UIColor(red: 0/255, green: 102/255, blue: 51/255, alpha: 1)
        popTip.titleColor = UIColor.whiteColor()
        popTip.textColor = UIColor.whiteColor()
        if sender.dynamicType === UIBarButtonItem.self {
            popTip.presentAnimatedPointingAtBarButtonItem(sender as! UIBarButtonItem, autodismissAtTime: 10)
        } else {
            popTip.presentAnimatedPointingAtView(sender as! UIView, inView: self.view, autodismissAtTime: 10)
        }
    }


    

   
}
