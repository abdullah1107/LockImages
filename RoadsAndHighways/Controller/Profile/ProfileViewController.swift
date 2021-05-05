//
//  ProfileViewController.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 8/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var topWhiteView: UIView!
    @IBOutlet weak var bottomWhiteView: UIView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var editProfileButton: UIButton!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var officeNameLabel: UILabel!
    @IBOutlet weak var personalIdLabel: UILabel!
    @IBOutlet weak var officialContactLabel: UILabel!
    @IBOutlet weak var personalContactLabel: UILabel!
    @IBOutlet weak var officeEmailLabel: UILabel!
    @IBOutlet weak var personalEmailLabel: UILabel!
    @IBOutlet weak var presentAddressLabel: UILabel!
    

    var profileData = OtpViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designProfileVC()
        
        let allData = profileData.getlogData()?.data?.user?[0]
        
        nameLabel.text = allData?.name
        officeNameLabel.text = (allData?.displayName ?? "") + "\n" + (allData?.officeName ?? "")
        personalIdLabel.text = ": \(allData?.personalID ?? 0)"
        officialContactLabel.text = ": " + (allData?.officialMobileNo ?? "")
        personalContactLabel.text = ": " + (allData?.personalContact ?? "")
        officeEmailLabel.text = ": " + (allData?.officialEMailID ?? "")
        personalEmailLabel.text = ": " + (allData?.pernonalEmail)!
        presentAddressLabel.text = ": " + (allData?.permanentAddress ?? "")
        
        profileImageView.image = profileImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileImageView.image = profileImage
    }
    
    @IBAction func editProfileButtonAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            
            if let navigation = self.navigationController {
                
                Navigation.shared.nextViewControllerwithID(stroyBoardID: "Fahim", storyBoardName: "editProfileVC", navigationController: navigation)
            }
        }
    }
}
