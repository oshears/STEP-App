//
//  AnnouncementsConentViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 3/9/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class AnnouncementConentTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate  {

    var announcement:Announcement!
    
    @IBOutlet weak var announcementTitle: UILabel!
    @IBOutlet weak var announcementPostDate: UILabel!
    @IBOutlet weak var announcementContent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = announcement.title
        
        //Self-Sizing
        tableView.estimatedRowHeight = 36.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        
        println(announcement.title)
        announcementTitle.text = announcement.title
        announcementContent.text = announcement.content
        announcementPostDate.text = announcement.postDate
        
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
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
