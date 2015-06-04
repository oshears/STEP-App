//
//  DetailedHoursTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 5/31/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class DetailedHoursTableViewController: UITableViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    var eatery:Eatery!
    
    @IBOutlet weak var weekHoursLabel: UILabel!
    @IBOutlet weak var additionalInfoLabel: UILabel!
    @IBOutlet weak var weekendHoursLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = eatery.title
        nameLabel.text = eatery.title
        logoImageView.image = UIImage(named: eatery.image)
        weekHoursLabel.text = eatery.weekHours
        weekendHoursLabel.text = eatery.weekendHours
        additionalInfoLabel.text = eatery.desc
        
        // Self Sizing Cells
        self.tableView.estimatedRowHeight = 123.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        //Update the cells again
        /*
        var indexPath:NSIndexPath=NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.cellForRowAtIndexPath(indexPath)?.setNeedsDisplay()
        indexPath=NSIndexPath(forRow: 1, inSection: 0)
        self.tableView.cellForRowAtIndexPath(indexPath)?.setNeedsDisplay()*/
        for x in 0...tableView.numberOfRowsInSection(0){
            var indexPath:NSIndexPath=NSIndexPath(forRow: x, inSection: 0)
            self.tableView.cellForRowAtIndexPath(indexPath)?.setNeedsDisplay()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
