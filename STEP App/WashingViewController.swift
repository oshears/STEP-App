//
//  WashingViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 6/8/16.
//  Copyright © 2016 OSApps. All rights reserved.
//

import UIKit

class WashingViewController: UIViewController {

    @IBOutlet weak var washingWebView: UIWebView!
    @IBOutlet weak var menuButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Side Menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        // Do any additional setup after loading the view.
        super.viewDidLoad()
        let url = NSURL(string: "http://gmu.esuds.net/RoomStatus/showRoomStatus.i?locationId=1030251")
        let request = NSURLRequest(URL: url!)
        washingWebView.loadRequest(request)
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
