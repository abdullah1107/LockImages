//
//  ItemCollectionViewCell.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 9/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nibView: UIView!
    @IBOutlet weak var nibImageView: UIImageView!
    @IBOutlet weak var nibLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nibView.layer.cornerRadius = 10
    }

}
