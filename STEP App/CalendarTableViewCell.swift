//
//  CalendarTableViewCell.swift
//  STEP App
//
//  Created by Osaze Shears on 3/15/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var fulldateLabel: UILabel!
    @IBOutlet weak var mainActivity1: UILabel!
    @IBOutlet weak var mainActivity2: UILabel!
    @IBOutlet weak var mainActivity3: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.Gray
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
