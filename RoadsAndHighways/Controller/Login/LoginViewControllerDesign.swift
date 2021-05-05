//
//  LoginViewControllerDesign.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 13/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

enum Rounder {
    
    static func roundView(getter:UIView){
        getter.layer.cornerRadius = 15.0
    }
    
    static func roundButton(getter:UIButton){
        getter.layer.cornerRadius = 10.0
    }
    
    static func placingTextField(loginTextField:UITextField, color:UIColor){
        loginTextField.attributedPlaceholder = NSAttributedString(string: " +88 Enter Mobile Number",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}


extension LoginViewController {
    
    func settingUI(){
        
        Rounder.roundView(getter: loginView)
        Rounder.roundButton(getter: nextButton)
        Rounder.placingTextField(loginTextField: loginTextField, color: UIColor.darkGray)
        loginTextField.keyboardType = .numberPad
    }
}
