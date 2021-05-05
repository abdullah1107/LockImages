//
//  HomeCollectionViewCell.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 8/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var homeCollectionImageView: UIImageView!
    
    @IBOutlet weak var homeCollectionLabel: UILabel!
    @IBOutlet weak var homeCollectionCellView: UIView!
    
    
    override func awakeFromNib() {
        homeCollectionCellView.layer.cornerRadius = 10
    }
    
}
