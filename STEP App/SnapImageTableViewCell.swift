//
//  SnapImageTableViewCell.swift
//  STEP App
//
//  Created by Osaze Shears on 6/3/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class SnapImageTableViewCell: UITableViewCell {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var imageImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
