//
//  SnapImageTableViewCell.swift
//  STEP App
//
//  Created by Osaze Shears on 6/3/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class SnapImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var snapView: UIView!

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var imageImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageImageView.layer.cornerRadius = 3
        
        snapView.layer.cornerRadius = 3
        snapView.layer.shadowOpacity = 0.5
        snapView.layer.shadowOffset = CGSizeMake(1, 1)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
