//
//  HoursTableViewCell.swift
//  STEP App
//
//  Created by Osaze Shears on 3/19/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class HoursTableViewCell: UITableViewCell {
    @IBOutlet weak var eateryImage: UIImageView!
    @IBOutlet weak var eateryTitle: UILabel!

    @IBOutlet weak var eateryWeekHours: UILabel!
    @IBOutlet weak var eateryWeekendHours: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //Dynamic Cell Height Fix?
    override func didMoveToSuperview() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.setNeedsDisplay()
    }

}
