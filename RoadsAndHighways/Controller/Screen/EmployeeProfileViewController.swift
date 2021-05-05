//
//  EmployeeProfileViewController.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 25/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class EmployeeProfileViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    
    @IBOutlet weak var topWhiteView: UIView!
    @IBOutlet weak var bottomWhiteView: UIView!
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var officeNameLabel: UILabel!
    @IBOutlet weak var personalIdLabel: UILabel!
    @IBOutlet weak var officialContactLabel: UILabel!
    @IBOutlet weak var personalContactLabel: UILabel!
    @IBOutlet weak var officeEmailLabel: UILabel!
    @IBOutlet weak var personalEmailLabel: UILabel!
    @IBOutlet weak var presentAddressLabel: UILabel!
    
    
    var name = String()
    var officeName = String()
    var personalId = Int()
    var officialContact = String()
    var personalContact = String()
    var officeEmail = String()
    var personalEmail = String()
    var presentAddress = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        designEmployeeProfile()
        showProfileData()
        getEmployeePhoto(personalId: personalId)
        
    }

    
    func showProfileData() {
        
        nameLabel.text = name
        officeNameLabel.text = officeName
        personalIdLabel.text = ": " + String(personalId)
        officialContactLabel.text = ": " + officialContact
        personalContactLabel.text = ": " + personalContact
        officeEmailLabel.text = ": " + officeEmail
        personalEmailLabel.text = ": " + personalEmail
        presentAddressLabel.text = ": " + presentAddress
    }
    
    
    
    @IBAction func sendSmsAction(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Badhon", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "HalfViewController") as? SMSViewController {
            vc.modalPresentationStyle = UIModalPresentationStyle.custom
            vc.transitioningDelegate = self
            phoneNumberForSms.append(personalContact)
            present(vc, animated: true)
        }
    }
    
    
    @IBAction func sendEmailAction(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Fahim", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "emailViewController") as? EmailViewController {
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
             return SetSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
    
}



extension EmployeeProfileViewController {
    
    func getEmployeePhoto(personalId: Int) {
        
        guard let getPhotoUrl = URL(string: UrlManager.baseURL() + "rhd/GetPhoto?COMPID=\(personalId)") else { return }
        
        var request = URLRequest(url: getPhotoUrl)
        
        request.setValue("Bearer \(defaults.string(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        request.timeoutInterval = .infinity
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                if let response = response as? HTTPURLResponse, response.isResponseOK() {
                    
                    guard let data = data else {
                        print(String(describing: error))
                        return
                    }

                    if let jsonResponse = try? JSONDecoder().decode(PhotoModel.self, from: data) {

                        if let imageString = jsonResponse.data?.photo {

                            if let imageData = Data(base64Encoded: imageString, options: .ignoreUnknownCharacters) {
                                
                                let employeeProfileImage = UIImage(data: imageData) ?? UIImage()
                                self.profileImageView.image = employeeProfileImage
                            }
                        }
                    }
                }
            }
        }.resume()
    }
}
