//
//  ItemTableViewCell.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 9/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var tableNibView: UIView!
    @IBOutlet weak var tableNibImageView: UIImageView!
    @IBOutlet weak var tableNibLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableNibView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
