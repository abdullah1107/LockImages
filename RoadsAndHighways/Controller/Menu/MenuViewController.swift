//
//  MenuViewController.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 7/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        .lightContent
    }
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var officeNameLabel: UILabel!
    
    var profileData = OtpViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designMenuView()
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.hideMenuTappingAnywhere))
        self.view.addGestureRecognizer(gesture)
        
        
        let allData = profileData.getlogData()?.data?.user?[0]
        
        nameLabel.text = allData?.name
        officeNameLabel.text = (allData?.displayName) ?? "" + "\n" + (allData?.officeName ?? "")
        
        self.profileImageView.image = profileImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.profileImageView.image = profileImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func logoutClicked(_ sender: UIButton) {
        
        defaults.removeObject(forKey: "token")
        
        let storyboard = UIStoryboard(name: "Fahim", bundle: nil)
        if #available(iOS 13.0, *) {
            let loginNavController = storyboard.instantiateViewController(identifier: "NavigationViewController")
            
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
        } else {
            let loginNavController = storyboard.instantiateViewController(withIdentifier: "NavigationViewController")
            (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(loginNavController)
        }
    }
    
    @IBAction func allEmployeeButtonAction(_ sender: Any) {
        
        if let navigation = self.navigationController {
            
            Navigation.shared.nextViewControllerwithID(stroyBoardID: "Badhon", storyBoardName: "EmployeeListViewController", navigationController: navigation)
        }
    }
    
    @IBAction func profileButtonAction(_ sender: UIButton) {
        
        if let navigation = self.navigationController {
            
            Navigation.shared.nextViewControllerwithID(stroyBoardID: "Fahim", storyBoardName: "profileVC", navigationController: navigation)
        }
    }
    
    
    @IBAction func crossButtonClicked(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            self.navigationController?.view.layer.add(transition, forKey: kCATransition)
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    
    
    @IBAction func chatButtonAction(_ sender: UIButton) {
        
        if let navigation = self.navigationController {
            
            Navigation.shared.nextViewControllerwithID(stroyBoardID: "Fahim", storyBoardName: "ChatListVC", navigationController: navigation)
        }
    }
    
    
    
    @objc func hideMenuTappingAnywhere() {
        
        DispatchQueue.main.async {
            
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            self.navigationController?.view.layer.add(transition, forKey: kCATransition)
            self.navigationController?.popViewController(animated: false)
        }
    }
}
