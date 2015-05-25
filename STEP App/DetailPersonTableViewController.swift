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
    var person:Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        title = person.name
        
        
        bioTextView.text = person.bio
        positionLabel.text = person.role
        profileImageView.image = UIImage(named:person.image)
        
        //No excess
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        
        
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
}
