//
//  EditProfileViewControllerDesign.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 9/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

extension EditProfileViewController {
    
    func designEditProfileVC() {
        
        self.backView.backgroundColor = UIColor(hex: "E5E5E5")
        self.saveAndUpdateButton.layer.cornerRadius = 10
        //self.profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        self.profileImageView.contentMode = .scaleToFill
        
        self.nameTextField.addPadding(padding: .left(20))
        self.idTextField.addPadding(padding: .left(20))
        self.designationTextField.addPadding(padding: .left(20))
        self.officeNameTextField.addPadding(padding: .left(20))
        self.circleOfficeTextField.addPadding(padding: .left(20))
        self.officialContactTextField.addPadding(padding: .left(20))
        self.personalContactTextField.addPadding(padding: .left(20))
        self.officialEmailTextField.addPadding(padding: .left(20))
        self.personalEmailTextField.addPadding(padding: .left(20))
        self.tinNumberTextField.addPadding(padding: .left(20))
        self.passportTextField.addPadding(padding: .left(20))
        self.drivingLicenceTextField.addPadding(padding: .left(20))
        self.maritalStatusTextField.addPadding(padding: .left(20))
        self.addressTextField.addPadding(padding: .left(20))
    }
}
