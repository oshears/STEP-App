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
        Eatery(title:"Chick fil A",weekHours:"Monday - Friday: 11:00 am - 3:00pm",weekendHours:"Saturday - Sunday: Closed",image:"chickfila"),
        Eatery(title:"Einstein's Bagels",weekHours:"Monday - Friday: 11:00 am - 3:00pm",weekendHours:"Saturday - Sunday: Closed",image:"einstein"),
        Eatery(title:"Subway",weekHours:"Monday - Friday: 11:00 am - 3:00pm",weekendHours:"Saturday - Sunday: Closed",image:"subway")
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
        self.tableView.estimatedRowHeight = 150.0;
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
        
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

   
}
