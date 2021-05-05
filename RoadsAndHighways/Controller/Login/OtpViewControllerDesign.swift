//
//  GetIdForLoginDesign.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 7/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

extension OtpViewController {
    
    func designGetIdForLogin() {
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        self.view.backgroundColor = UIColor.white
        self.middleView.backgroundColor = UIColor(hex: "00A14B")
        self.middleView.layer.cornerRadius = 15
        
        self.otpConfirmButton.layer.cornerRadius = 10
        
        self.otp1TextField.delegate = self
        self.otp2TextField.delegate = self
        self.otp3TextField.delegate = self
        self.otp4TextField.delegate = self
        self.otp5TextField.delegate = self
        self.otp6TextField.delegate = self
        
        self.otp1TextField.maxLength = 1
        self.otp1TextField.valueType = .onlyNumbers
        
        self.otp2TextField.maxLength = 1
        self.otp2TextField.valueType = .onlyNumbers
        
        self.otp3TextField.maxLength = 1
        self.otp4TextField.valueType = .onlyNumbers
        
        self.otp4TextField.maxLength = 1
        self.otp4TextField.valueType = .onlyNumbers
        
        self.otp5TextField.maxLength = 1
        self.otp5TextField.valueType = .onlyNumbers
        
        self.otp6TextField.maxLength = 1
        self.otp6TextField.valueType = .onlyNumbers
        
        self.otp1TextField.keyboardType = .numberPad
        self.otp2TextField.keyboardType = .numberPad
        self.otp3TextField.keyboardType = .numberPad
        self.otp4TextField.keyboardType = .numberPad
        self.otp5TextField.keyboardType = .numberPad
        self.otp6TextField.keyboardType = .numberPad
        
    }
}
