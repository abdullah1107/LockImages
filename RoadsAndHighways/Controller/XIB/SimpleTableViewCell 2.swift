//
//  SimpleTableViewCell.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 11/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {

    @IBOutlet weak var simpleCellView: UIView!
    @IBOutlet weak var simpleCellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        simpleCellView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
