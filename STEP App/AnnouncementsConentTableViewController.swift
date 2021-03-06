//
//  AnnouncementsConentViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 3/9/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class AnnouncementConentTableViewController: UITableViewController{

    var announcement:Announcement!
    
    @IBOutlet weak var announcementTitle: UILabel!
    @IBOutlet weak var announcementPostDate: UILabel!
    @IBOutlet weak var announcementContent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = announcement.title
        
        
        
        print(announcement.title)
        announcementTitle.text = announcement.title
        announcementContent.text = announcement.content
        announcementPostDate.text = announcement.postDate
        
        //No excess
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        
        //Self-Sizing
        //tableView.estimatedRowHeight = 36.0;
        //tableView.rowHeight = UITableViewAutomaticDimension;
        
        // Self Sizing Cells
        self.tableView.estimatedRowHeight = 131.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        //Update the cells again
        /*
        var indexPath:NSIndexPath=NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.cellForRowAtIndexPath(indexPath)?.setNeedsDisplay()
        indexPath=NSIndexPath(forRow: 1, inSection: 0)
        self.tableView.cellForRowAtIndexPath(indexPath)?.setNeedsDisplay()*/
        for x in 0...tableView.numberOfRowsInSection(0){
            print("fixing cell -> \(x)")
            let indexPath:NSIndexPath=NSIndexPath(forRow: x, inSection: 0)
            self.tableView.cellForRowAtIndexPath(indexPath)?.setNeedsDisplay()
        }
        
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
