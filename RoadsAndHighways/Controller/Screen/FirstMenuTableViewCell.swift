//
//  ChiefEngineersTableViewCell.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 11/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class FirstMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var cheffCellView: UIView!
    @IBOutlet weak var chefTableCellLabel: UILabel!
    
    @IBOutlet weak var firstCellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cheffCellView.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
