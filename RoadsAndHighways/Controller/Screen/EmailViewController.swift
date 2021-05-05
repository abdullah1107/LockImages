//
//  EmailViewController.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 26/8/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {
    
    @IBOutlet weak var subjectTextField: UITextField!
    
    @IBOutlet weak var bodyTextField: UITextField!
    
    @IBOutlet weak var emailAttachmentTableView: UITableView!
    
    var attachmentImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        touchToDismissKeyboard()
        self.view.backgroundColor = UIColor(hex: "#FFFFFF")
        emailAttachmentTableView.backgroundColor = .white
        emailAttachmentTableView.tableFooterView = UIView()
        
        subjectTextField.delegate = self
        bodyTextField.delegate = self
        emailAttachmentTableView.delegate = self
        emailAttachmentTableView.dataSource = self
    }
    
    @IBAction func attachmentButtonAction(_ sender: UIButton) {
        
        photoPicker()
    }
    
    @IBAction func sendButtonAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            self.showSimpleHUD(hudView: self.view)
        }
        
        for email in 0...emailAddressForEmail.count - 1 {
            
            sendEmailApiCalled(emailAddress: emailAddressForEmail[email], subject: subjectTextField.text ?? "", emailBody: bodyTextField.text ?? "")
        }
    }
}


// press return to hide keyboard

extension EmailViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}




// could't provide document attachment. if you don't run on real device not having paid apple id the document picker and icloud feature won't work.

// pick photo attachment for email

extension EmailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func photoPicker() {
        
        let imageController = UIImagePickerController()
        imageController.delegate =  self
        imageController.sourceType  = UIImagePickerController.SourceType.photoLibrary
        self.present(imageController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        attachmentImages.append((info[UIImagePickerController.InfoKey.originalImage] as? UIImage ?? UIImage()))
        
        emailAttachmentTableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}



// attachment tableView

extension EmailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return attachmentImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EmailAttachmentTableViewCell = emailAttachmentTableView.dequeueReusableCell(withIdentifier: "attachmentCell", for: indexPath) as! EmailAttachmentTableViewCell
        
        cell.attachmentImageView.image = attachmentImages[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 180
    }
}






// email api

extension EmailViewController {
    
    func sendEmailApiCalled(emailAddress:String ,subject: String, emailBody: String) {
        
        let parameters = [
            [
                "key": "subject",
                "value": "\(subject)",
                "type": "text"
            ],
            [
                "key": "body",
                "value": "\(emailBody)",
                "type": "text"
            ],
            [
                "key": "email",
                "value": "\(emailAddress)",
                "type": "text"
            ]] as [[String : Any]]
        
        
        let boundary = "Boundary-\(UUID().uuidString)"
        var body = ""
        for param in parameters {
            if param["disabled"] == nil {
                let paramName = param["key"]!
                body += "--\(boundary)\r\n"
                body += "Content-Disposition:form-data; name=\"\(paramName)\""
                let paramType = param["type"] as! String
                if paramType == "text" {
                    let paramValue = param["value"] as! String
                    body += "\r\n\r\n\(paramValue)\r\n"
                } else {
                    let paramSrc = param["src"] as! String
                    guard let fileData = try? NSData(contentsOfFile:paramSrc, options:[]) as Data else { return }
                    let fileContent = String(data: fileData, encoding: .utf8)!
                    body += "; filename=\"\(paramSrc)\"\r\n"
                        + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
                }
            }
        }
        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)
        
        guard let smsUrl = URL(string: UrlManager.baseURL() + "email/SendEmail") else { return }
        var request = URLRequest(url: smsUrl)
        
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        request.timeoutInterval = .infinity
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                if let response = response as? HTTPURLResponse, response.isResponseOK() {
                    
                    self.customAlert(alertTitle: "Email Successfully Sent", alertMessage: "", actionTitle: "OK")
                    hud.dismiss(animated: true)
                }
            }
        }.resume()
    }
}
