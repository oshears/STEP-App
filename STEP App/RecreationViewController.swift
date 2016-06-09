//
//  RecreationViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 6/9/16.
//  Copyright © 2016 OSApps. All rights reserved.
//

import UIKit

class RecreationViewController: UIViewController {

    @IBOutlet weak var recreationWebView: UIWebView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Side Menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        let url = NSURL(string: "http://recreation.gmu.edu/facilities/rac/")
        let request = NSURLRequest(URL: url!)
        recreationWebView.loadRequest(request)
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
