//
//  FullCalendarViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 6/8/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class FullCalendarViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var calendarImge: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.scrollView.minimumZoomScale=1;
        self.scrollView.maximumZoomScale=3;
        self.scrollView.contentSize=CGSizeMake(568, 536);
        self.scrollView.delegate=self;
        scrollView.addSubview(calendarImge)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first as? UIView
    }
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
        self.scrollView.transform=CGAffineTransformMakeScale(scale, scale)
    }
    



}
