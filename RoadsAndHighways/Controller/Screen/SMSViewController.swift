//
//  HalfViewController.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 25/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class SMSViewController: UIViewController {
    
    @IBOutlet weak var smsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        touchToDismissKeyboard()
    }
    
    @IBAction func sendSmsButtonAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            self.showSimpleHUD(hudView: self.view)
        }
        
        for phoneNumber in 0...phoneNumberForSms.count - 1 {
            if smsTextField.text != "" && !phoneNumberForSms.isEmpty {
                
                sendSmsApiCalled(phoneNumber: phoneNumberForSms[phoneNumber], smsBody: smsTextField.text!)
            }
        }
    }

    
    @IBAction func closeButtton(_ sender: Any) {
          
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}



// send sms API
extension SMSViewController {
    
    func sendSmsApiCalled(phoneNumber: String, smsBody: String) {
        
        let parameters = "{\r\n    \"Mobile\":\"\(phoneNumber)\",\r\n    \"SMSBody\":\"\(smsBody)\"\r\n}"
        
        let postData = parameters.data(using: .utf8)
        
        guard let smsUrl = URL(string: UrlManager.baseURL() + "sms/sendsms") else { return }
        var request = URLRequest(url: smsUrl)
    
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        request.timeoutInterval = .infinity
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                if let response = response as? HTTPURLResponse, response.isResponseOK() {
                    
                    self.customAlert(alertTitle: "SMS Successfully Sent", alertMessage: "", actionTitle: "OK")
                    hud.dismiss(animated: true)
                }
            }
        }.resume()
    }
}
