//
//  FAQTableViewCell.swift
//  STEP App
//
//  Created by Osaze Shears on 5/29/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class FAQTableViewCell: UITableViewCell {

    
    @IBOutlet weak var questionLabel: UILabel!

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
        self.layoutIfNeeded()
    }

}
