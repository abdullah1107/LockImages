//
//  Utility.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 7/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit
import JGProgressHUD

let hud = JGProgressHUD(style: .light)

let defaults = UserDefaults.standard

var profileImage: UIImage?

var phoneNumberForSms = [String]()
var emailAddressForEmail = [String]()

// use hex code for color selection
extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) { cString.removeFirst() }
        
        if ((cString.count) != 6) {
            self.init(hex: "ff0000") // return red color for wrong hex input
            return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}


// touch anywhere to dismiss keyboard

extension UIViewController {
    
    func touchToDismissKeyboard() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
}

// text padding for textfield

extension UITextField {
    
    enum PaddingSpace {
        case left(CGFloat)
        case right(CGFloat)
        case equalSpacing(CGFloat)
    }
    
    func addPadding(padding: PaddingSpace) {
        
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        
        switch padding {
            
            case .left(let spacing):
                let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
                self.leftView = leftPaddingView
                self.leftViewMode = .always
            
            case .right(let spacing):
                let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
                self.rightView = rightPaddingView
                self.rightViewMode = .always
            
            case .equalSpacing(let spacing):
                let equalPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
                // left
                self.leftView = equalPaddingView
                self.leftViewMode = .always
                // right
                self.rightView = equalPaddingView
                self.rightViewMode = .always
        }
    }
}



// textfild text limit restriction

enum ValueType: Int {
    case none
    case onlyLetters
    case onlyNumbers
    case phoneNumber   // Allowed "+0123456789"
    case alphaNumeric
    case fullName       // Allowed letters and space
}

class SDCTextField: UITextField {
    
    @IBInspectable var maxLength: Int = 0 // Max character length
    var valueType: ValueType = ValueType.none // Allowed characters
    
    /************* Added new feature ***********************/
    // Accept only given character in string, this is case sensitive
    @IBInspectable var allowedCharInString: String = ""
    
    func verifyFields(shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch valueType {
            case .none:
                break // Do nothing
            
            case .onlyLetters:
                let characterSet = CharacterSet.letters
                if string.rangeOfCharacter(from: characterSet.inverted) != nil {
                    return false
            }
            
            case .onlyNumbers:
                let numberSet = CharacterSet.decimalDigits
                if string.rangeOfCharacter(from: numberSet.inverted) != nil {
                    return false
            }
            
            case .phoneNumber:
                let phoneNumberSet = CharacterSet(charactersIn: "+0123456789")
                if string.rangeOfCharacter(from: phoneNumberSet.inverted) != nil {
                    return false
            }
            
            case .alphaNumeric:
                let alphaNumericSet = CharacterSet.alphanumerics
                if string.rangeOfCharacter(from: alphaNumericSet.inverted) != nil {
                    return false
            }
            
            case .fullName:
                var characterSet = CharacterSet.letters
                print(characterSet)
                characterSet = characterSet.union(CharacterSet(charactersIn: " "))
                if string.rangeOfCharacter(from: characterSet.inverted) != nil {
                    return false
            }
        }
        
        if let text = self.text, let textRange = Range(range, in: text) {
            let finalText = text.replacingCharacters(in: textRange, with: string)
            if maxLength > 0, maxLength < finalText.utf8.count {
                return false
            }
        }
        
        // Check supported custom characters
        if !self.allowedCharInString.isEmpty {
            let customSet = CharacterSet(charactersIn: self.allowedCharInString)
            if string.rangeOfCharacter(from: customSet.inverted) != nil {
                return false
            }
        }
        
        return true
    }
}



// progress HUD

extension UIViewController {
    
    func showSimpleHUD(hudView: UIView) {
        
        hud.vibrancyEnabled = true
        hud.square = true
        hud.show(in: hudView)
    }
}



// check status code is valid or not

extension HTTPURLResponse {
    func isResponseOK() -> Bool {
        return (200...299).contains(self.statusCode)
    }
}


// show alert

extension UIViewController {
    
    func customAlert(alertTitle: String, alertMessage: String, actionTitle: String) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}


// check phone number is valid or not
extension UIViewController {
    
    func isValidPhone(phone: String) -> Bool {
        
        let phoneRegx = "^[0-9+]{0,1}+[0-9]{5,16}$"
        
        let phoneCheck = NSPredicate(format:"SELF MATCHES %@", phoneRegx)
        
        return phoneCheck.evaluate(with: phone)
        
    }
}



// dark navigation back and white text

extension UIViewController {
    
    func customNavigationBar(navBarBackColor: String) {
        
        navigationController?.navigationBar.barTintColor = UIColor(hex: navBarBackColor)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
}





// custom home button on nav bar

extension UIViewController {
    
    func navigationHomeButton() {
        
        let rightItem = UIBarButtonItem(image: UIImage(named: "homeIcon"), style: .plain, target: self,action: #selector(rightNavigationItemClicked))
        self.navigationItem.rightBarButtonItem  = rightItem
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    
    @objc func rightNavigationItemClicked() {
        
        DispatchQueue.main.async {
            
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}



extension UIViewController{
    
    func buttonDesign(button: UIButton){
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "ffffff")
        button.tintColor = UIColor(hex: "000000")
    }
}



extension UISearchBar {
    
    var textColor: UIColor? {
        get {
            if let textField = self.value(forKey: "searchField") as?
                UITextField  {
                return textField.textColor
            } else {
                return nil
            }
        }
        
        set (newValue) {
            if let textField = self.value(forKey: "searchField") as?
                UITextField  {
                textField.textColor = newValue
            }
        }
    }
}
