//
//  DetailFAQTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 5/29/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class DetailFAQTableViewController: UITableViewController {

    var faq:FAQ!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
        
        //No excess
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        
        title = "FAQs"
        questionLabel.text = faq.question
        answerLabel.text = (faq.answer=="") ? "This question has no answer yet." : faq.answer
        
        //Self-Sizing
        tableView.estimatedRowHeight = 100.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        
        //Update the cells again
        /*
        var indexPath:NSIndexPath=NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.cellForRowAtIndexPath(indexPath)?.setNeedsDisplay()
        indexPath=NSIndexPath(forRow: 1, inSection: 0)
        self.tableView.cellForRowAtIndexPath(indexPath)?.setNeedsDisplay()*/
        /*
        for x in 0...tableView.numberOfRowsInSection(0){
            var indexPath:NSIndexPath=NSIndexPath(forRow: x, inSection: 0)
            self.tableView.cellForRowAtIndexPath(indexPath)?.setNeedsLayout()
        }*/
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        self.tableView.layoutIfNeeded();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }


    

}
