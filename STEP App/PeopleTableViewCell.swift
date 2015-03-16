//
//  PeopleTableViewCell.swift
//  STEP App
//
//  Created by Osaze Shears on 3/16/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!

    @IBOutlet weak var profileImge: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
