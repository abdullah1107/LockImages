//
//  MenuViewControllerDesign.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 7/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit


extension MenuViewController {
    
    func designMenuView() {
        
        self.view.backgroundColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.5)
        self.view.isOpaque = false
        
        self.profileView.layer.borderWidth = 0.2
        self.profileView.layer.borderColor = UIColor.darkGray.cgColor
        
        self.logoutView.layer.borderWidth = 0.2
        self.logoutView.layer.borderColor = UIColor.darkGray.cgColor
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        self.profileImageView.contentMode = .scaleToFill
        
    }
}
