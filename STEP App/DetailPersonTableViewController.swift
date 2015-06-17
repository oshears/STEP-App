//
//  DetailPersonTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 5/25/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class DetailPersonTableViewController: UITableViewController {
    
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var person:Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        title = person.name
        nameLabel.text = person.name
        
        
        bioTextView.text = person.bio
        positionLabel.text = person.role
        profileImageView.image = UIImage(named:person.image)
        
        // Circular image
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 4
        profileImageView.clipsToBounds = true
        
        //Textview Outline
        bioTextView.layer.borderColor = UIColor.blackColor().CGColor
        bioTextView.layer.borderWidth = 0.5
        bioTextView.layer.cornerRadius = 5
        //Scroll to top
        self.bioTextView.scrollRangeToVisible(NSMakeRange(0, 1))
        
        //No excess
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        
        // Self Sizing Cells
        self.tableView.estimatedRowHeight = 100.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layoutIfNeeded()
        cell.setNeedsDisplay()
    }
}
