//
//  AnnoucementTableViewCell.swift
//  STEP App
//
//  Created by Osaze Shears on 3/8/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class AnnoucementTableViewCell: UITableViewCell {


    @IBOutlet weak var announcementImage: UIImageView!
    @IBOutlet weak var announcementTitle: UILabel!
    @IBOutlet weak var announcementTime: UILabel!
    
    
    @IBOutlet weak var announcementViewStyle: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        var screenRect:CGRect = UIScreen.mainScreen().bounds
        
        
        /*var whiteRoundedCornerView = UIView(frame: CGRectMake(10, 10, screenRect.width - 20, 90))
        whiteRoundedCornerView.backgroundColor = UIColor.whiteColor()
        whiteRoundedCornerView.layer.masksToBounds = false
        whiteRoundedCornerView.layer.cornerRadius = 3
        whiteRoundedCornerView.layer.shadowOffset = CGSizeMake(-1, 1)
        whiteRoundedCornerView.layer.shadowOpacity = 0.5
        self.contentView.addSubview(whiteRoundedCornerView)
        self.contentView.sendSubviewToBack(whiteRoundedCornerView)*/
        
        self.backgroundColor = UIColor(red: 220/255, green: 222/255, blue: 223/255, alpha: 1)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
