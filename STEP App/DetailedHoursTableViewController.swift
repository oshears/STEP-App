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
        
        self.title=eatery.title
        logoImageView.image = UIImage(named: eatery.image)
        weekHoursLabel.text = eatery.weekHours
        weekendHoursLabel.text = eatery.weekendHours
        additionalInfoLabel.text = eatery.desc
        
        // Self Sizing Cells
        self.tableView.estimatedRowHeight = 123.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
