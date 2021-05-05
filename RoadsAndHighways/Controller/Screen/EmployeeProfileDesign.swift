//
//  EmployeeProfileDesign.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 25/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

extension EmployeeProfileViewController {
    
    func designEmployeeProfile() {
        
        self.view.backgroundColor = UIColor(hex: "#E5E5E5")
        self.topWhiteView.backgroundColor = UIColor.white
        self.topWhiteView.layer.cornerRadius = 15
        
        self.bottomWhiteView.backgroundColor = UIColor.white
        self.bottomWhiteView.layer.cornerRadius = 15

        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        self.profileImageView.contentMode = .scaleToFill
        
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "00A14B")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
    }
    
}
