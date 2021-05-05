//
//  AllEmployeeTableViewCell.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 22/10/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class AllEmployeeTableViewforChatCell: UITableViewCell {
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        accessoryType = selected ? UITableViewCell.AccessoryType.checkmark : UITableViewCell.AccessoryType.none
    }
}
