//
//  ViewController.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 7/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class OtpViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var middleView: UIView!
    
    @IBOutlet weak var otpConfirmButton: UIButton!
    
    @IBOutlet weak var otp1TextField: SDCTextField!
    @IBOutlet weak var otp2TextField: SDCTextField!
    @IBOutlet weak var otp3TextField: SDCTextField!
    @IBOutlet weak var otp4TextField: SDCTextField!
    @IBOutlet weak var otp5TextField: SDCTextField!
    @IBOutlet weak var otp6TextField: SDCTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designGetIdForLogin()
        touchToDismissKeyboard()
        autoScrollAdjustWhenKeyboardIsUP()
        autoSwitchTextFields()
        print("OTP", otp)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        otp1TextField.becomeFirstResponder()
    }
    
    
    
    @IBAction func otpConfirmButtonAction(_ sender: UIButton) {
        
        let allOtpTextFields = [otp1TextField, otp2TextField, otp3TextField, otp4TextField, otp5TextField, otp6TextField].map { $0.text ?? "" }
            .contains { $0.isEmpty }
        
        if !allOtpTextFields {
            
            let userTypedOtp = [otp1TextField.text!, otp2TextField.text!, otp3TextField.text!, otp4TextField.text!, otp5TextField.text!, otp6TextField.text!].joined()

    
            if userTypedOtp == otp {
                
                loginRequest(mobileNumber: defaults.string(forKey: "mobileNumber")!)
                
                
                DispatchQueue.main.async {
                    self.showSimpleHUD(hudView: self.view)
                }
            }
            else {
                self.customAlert(alertTitle: "Error", alertMessage: "Incorrect OTP", actionTitle: "Try Again")
            }
        }
        else {
            
            self.customAlert(alertTitle: "Error", alertMessage: "Empty Fields", actionTitle: "Try Again")
        }
    }
}



// api request

extension OtpViewController {
    
    func loginRequest(mobileNumber: String) {
        
        guard let loginUrl = URL(string: UrlManager.baseURL() + "login/UserLogin") else { return }
        
        let parameters = "{\r\n    \"Mobile\":\"\(mobileNumber)\"\r\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: loginUrl)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        request.timeoutInterval = .infinity
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                if let response = response as? HTTPURLResponse, response.isResponseOK() {
                    
                    guard let data = data else {
                        print(String(describing: error))
                        return
                    }
                    
                    if let jsonResponse = try? JSONDecoder().decode(Login.self, from: data) {
                        
                        defaults.set(jsonResponse.data?.token, forKey: "token")
                        
                        loginData = jsonResponse
                    }
                    
                    let storyboard = UIStoryboard(name: "Badhon", bundle: nil)
                    
                    if let vc = storyboard.instantiateViewController(withIdentifier: "homeVC") as? HomeViewController {
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                    hud.dismiss(animated: true)
                }
            }
        }.resume()
    }
}




// singleton
extension OtpViewController {
    
    func getlogData() -> Login? {
        
        return Singleton.shared.getlogData()
    }
}




// for adjusting view height when it shows

extension OtpViewController {
    
    
    func autoScrollAdjustWhenKeyboardIsUP() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + middleView.frame.height / 2
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}






// allow only one character for every textfields

extension OtpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Verify all the conditions
        if let sdcTextField = textField as? SDCTextField {
            
            return sdcTextField.verifyFields(shouldChangeCharactersIn: range, replacementString: string)
        }
        return false
    }
}





// auto switch text fields

extension OtpViewController {
    
    func autoSwitchTextFields() {
        
        otp1TextField?.addTarget(self, action: #selector(OtpViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        otp2TextField?.addTarget(self, action: #selector(OtpViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        otp3TextField?.addTarget(self, action: #selector(OtpViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        otp4TextField?.addTarget(self, action: #selector(OtpViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        otp5TextField?.addTarget(self, action: #selector(OtpViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        otp6TextField?.addTarget(self, action: #selector(OtpViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField == otp1TextField {
            if (textField.text?.count)! == 1 {
                otp2TextField?.becomeFirstResponder()
            }
        }
        
        
        if textField == otp2TextField {
            if (textField.text?.count)! == 1 {
                otp3TextField.becomeFirstResponder()
            }
        }
        
        if textField == otp3TextField {
            if (textField.text?.count)! == 1 {
                otp4TextField.becomeFirstResponder()
            }
        }
        
        if textField == otp4TextField {
            if (textField.text?.count)! == 1 {
                otp5TextField.becomeFirstResponder()
            }
        }
        
        if textField == otp5TextField {
            if (textField.text?.count)! == 1 {
                otp6TextField.becomeFirstResponder()
            }
        }
        
        if textField == otp6TextField {
            if (textField.text?.count)! == 1 {
                otp6TextField.resignFirstResponder()
            }
        }
    }
}
