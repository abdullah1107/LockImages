//
//  EditProfileViewController.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 9/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var saveAndUpdateButton: UIButton!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var designationTextField: UITextField!
    @IBOutlet weak var officeNameTextField: UITextField!
    @IBOutlet weak var circleOfficeTextField: UITextField!
    @IBOutlet weak var officialContactTextField: UITextField!
    @IBOutlet weak var personalContactTextField: UITextField!
    @IBOutlet weak var officialEmailTextField: UITextField!
    @IBOutlet weak var personalEmailTextField: UITextField!
    @IBOutlet weak var tinNumberTextField: UITextField!
    @IBOutlet weak var passportTextField: UITextField!
    @IBOutlet weak var drivingLicenceTextField: UITextField!
    @IBOutlet weak var maritalStatusTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    var profileData = OtpViewController()
    
    var pickedImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designEditProfileVC()
        
        touchToDismissKeyboard()
        
        let allData = profileData.getlogData()?.data?.user?[0]
        
        nameTextField.text = allData?.name
        officeNameTextField.text = (allData?.displayName ?? "") + "\n" + (allData?.officeName ?? "")
        idTextField.text = "\(allData?.personalID ?? 0)"
        officialContactTextField.text = (allData?.officialMobileNo ?? "")
        personalContactTextField.text = (allData?.personalContact ?? "")
        officialEmailTextField.text = (allData?.officialEMailID ?? "")
        personalEmailTextField.text = (allData?.pernonalEmail)!
        addressTextField.text = (allData?.permanentAddress ?? "")
        self.pickedImage = profileImage ?? UIImage()
        profileImageView.image = profileImage
    }
    
    @IBAction func saveAndUpdateButtonAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            self.showSimpleHUD(hudView: self.view)
        }
        saveAndUpdateProfile()
    }
    
    
    @IBAction func photoPickerButtonAction(_ sender: UIButton) {
       
        photoPicker()
        
    }
}




// update profile post

extension EditProfileViewController {
    
    func saveAndUpdateProfile() {
        
        guard let updatePersonalDataUrl = URL(string: UrlManager.baseURL() + "rhd/UpdatePersonalData") else { return }
        
        let parameters = "{\r\n  \"PersonalID\":\(idTextField.text ?? ""),\r\n  \"name\": \"\(nameTextField.text ?? "")\",\r\n  \"lastName\": \"Momtaz1\",\r\n  \"nickName\": \"Sharmin\",\r\n  \"father\": \"Late Kazi  Abdul Hai\",\r\n  \"mother\": \"Sayoda Hasina Begom\",\r\n  \"presentAddress\": \"\(addressTextField.text ?? "")\",\r\n  \"presentTel\": \"\(personalContactTextField.text ?? "")\",\r\n  \"OfficialEMailID\":\"\(officialEmailTextField.text ?? "")\",\r\n \"PassportNo\":\"\(passportTextField.text ?? "")\",\r\n \"MaritalStatus\":\"M\",\r\n \"NationalID\":\"674646464\",\r\n \"OfficialMobileNo\":\"\(officialContactTextField.text ?? "")\",\r\n\r\n}"
        
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: updatePersonalDataUrl)
        
        request.addValue("Bearer \(defaults.string(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        request.httpBody = postData
        request.timeoutInterval = .infinity
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                if let response = response as? HTTPURLResponse, response.isResponseOK() {
                    
                    let allData = self.profileData.getlogData()?.data?.user?[0]
                    
                    let pickedImageDataWithCompression = self.pickedImage.jpegData(compressionQuality: 1.0)

                    if let pickedImageWithCompression = UIImage(data: pickedImageDataWithCompression ?? Data()) {
                    
                        self.postPhoto(personalId: allData?.personalID ?? 0, selectedImage: pickedImageWithCompression)
                    }
                    
                    self.customAlert(alertTitle: "Profile data updated", alertMessage: "", actionTitle: "OK")
                    hud.dismiss(animated: true)
                }
            }
        }.resume()
    }
}




extension EditProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func photoPicker() {
        
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType  = UIImagePickerController.SourceType.photoLibrary
        self.present(imageController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        profileImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        pickedImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
        self.dismiss(animated: true, completion: nil)
    }
}






// edit photo request
 
extension EditProfileViewController {
    
    @objc func postPhoto(personalId: Int, selectedImage: UIImage) {
        
        let photoString = selectedImage.jpegData(compressionQuality: 1)?.base64EncodedString()
        
        let parameters = "{\r\n  \"COMPID\": \"\(personalId)\",\r\n  \"Photo\": \"\(photoString!)\"\r\n}"
        
        let postData = parameters.data(using: .utf8)
        
        guard let postPhotoUrl = URL(string: UrlManager.baseURL() + "rhd/UpdatePhoto") else { return }

        var request = URLRequest(url: postPhotoUrl)
        
        request.addValue("Bearer \(defaults.string(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "PUT"
        request.httpBody = postData
        request.timeoutInterval = .infinity
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
               
                if let response = response as? HTTPURLResponse, response.isResponseOK() {

                    self.customAlert(alertTitle: "Photo Successfully Updated", alertMessage: "", actionTitle: "OK")
                    
                    let profileData = OtpViewController()
                    let allData = profileData.getlogData()?.data?.user?[0]
                    self.getPhoto(personalId: allData?.personalID ?? 0)
                }
            }
        }.resume()
    }
}
