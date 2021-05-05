//
//  LoginViewController.swift
//  RoadsAndHighways
//
//  Created by Muhammad Abdullah Al Mamun on 11/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingUI()
        touchToDismissKeyboard()
        autoScrollAdjustWhenKeyboardIsUP()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        
        if loginTextField.text != "" {
            
            if isValidPhone(phone: loginTextField.text!) {
                
                postMobileNumberToGetOtp(mobileNumber: loginTextField.text ?? "")
                
                DispatchQueue.main.async {
                    self.showSimpleHUD(hudView: self.view)
                }
            }
            else {
                self.customAlert(alertTitle: "Error", alertMessage: "Please Enter a valid mobile number", actionTitle: "Try Again")
            }
        }
        
        else {
            
            hud.dismiss(animated: true)
            self.customAlert(alertTitle: "Error", alertMessage: "Field is empty", actionTitle: "Try Again")
        }
    }
}






// API request
extension LoginViewController {
    // API request
    
    func postMobileNumberToGetOtp(mobileNumber: String) {
        
        guard let postMobileNumberUrl = URL(string: UrlManager.baseURL() + "sms/sendsms") else { return }
        
        let parameters = "{\r\n    \"Mobile\":\"\(mobileNumber)\",\r\n    \"SMSBody\":\"\(generateOTP())\"\r\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: postMobileNumberUrl)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        request.timeoutInterval = .infinity
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                if let response = response as? HTTPURLResponse, response.isResponseOK() {
                    
                    let storyboard = UIStoryboard(name: "Fahim", bundle: nil)
                    
                    if let vc = storyboard.instantiateViewController(withIdentifier: "otpVC") as? OtpViewController {
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        defaults.set(mobileNumber, forKey: "mobileNumber")
                        
                    }
                    
                    hud.dismiss(animated: true)
                }
            }
        }.resume()
    }
}






extension LoginViewController {
    
    // generate 6 digit OTP
    
    func generateOTP() -> String {
        otp.removeAll()
        for _ in 1...6 {
            otp += "\(Int.random(in: 1...9))"
        }
        return otp
    }
}





// for adjusting view height when it shows

extension LoginViewController {
    
    
    func autoScrollAdjustWhenKeyboardIsUP() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + loginView.frame.height / 2
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}
