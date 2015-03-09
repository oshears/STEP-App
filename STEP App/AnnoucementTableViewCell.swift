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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
