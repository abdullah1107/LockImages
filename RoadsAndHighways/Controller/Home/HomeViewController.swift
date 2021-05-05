//
//  HomeViewController.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 8/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.

// add method and issue solve in HomeView(Mamun)


import UIKit
import MarqueeLabel

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout, CAAnimationDelegate {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    @IBOutlet weak var scrollLabel: MarqueeLabel!
    
    @IBOutlet weak var chiefView: UIView!
    
    @IBOutlet weak var chiefButton: UIButton!
    
    var name =  String()
    var officeName = String()
    var personalId = Int()
    var officialContact = String()
    var personalContact = String()
    var officeEmail = String()
    var personalEmail = String()
    var presentAddress = String()
    
    
    fileprivate var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    var mainCategory : CategoryBase?
    
    var rightItem: UIBarButtonItem!
    
    var navBarBackColor = "00A14B"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.isUserInteractionEnabled = false
        
        self.title = "RHD APP"
        
        
        chiefView.layer.cornerRadius = 64
        chiefButton.layer.cornerRadius = 58
        
        mainCategory = nil
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.showsVerticalScrollIndicator = false
        
        self.setNavigation()
        
        
        if defaults.string(forKey: "token") != "" {
            
            loginRequest(mobileNumber: defaults.string(forKey: "mobileNumber")!)
            
            DispatchQueue.main.async {
                self.showSimpleHUD(hudView: self.view)
            }
        }
        
        let scrollText = "কোভিড-১৯ সংক্রমনের সম্ভাব্য Second Wave মোকাবেলায় মাস্ক পরিধান ও স্বাস্থ্যবিধি প্রতিপালন নিশ্চিতকরণের লক্ষ্যে ব্যাপক প্রচারণা সংক্রান্ত (No Mask, No Entry)"
        
        self.scrollLabel.type = .continuous
        self.scrollLabel.speed = .duration(20)
        self.scrollLabel.animationCurve = .linear
        self.scrollLabel.text = scrollText
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        navigationItem.rightBarButtonItem = nil
    }
    

    @IBAction func chiefButtonAction(_ sender: Any) {
        //print("get chiefData",defaults.string(forKey: "token")!)
        
        if defaults.string(forKey: "token") != nil{
            self.getChiefData(token:"\(defaults.string(forKey: "token") ?? "")")
        }else{
           debugPrint("token is nil")
        }
        
        
        
    }
    
    func getChiefData(token: String) {
        print(token)
        
        guard let employeeListUrl = URL(string: UrlManager.baseURL() + "rhd/GetChiefEngineer/") else { return }
        
        var request = URLRequest(url: employeeListUrl)
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.timeoutInterval = .infinity
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                if let response = response as? HTTPURLResponse, response.isResponseOK() {
                   // print(response)
                    
                    guard let data = data else {
                        //debugPrint("data", data as! Data)
                        print(String(describing: error))
                        return
                    }
                    print(data)
                    
                    if let jsonResponse = try? JSONDecoder().decode(ChefEngDataBase.self, from: data) {
                        
                        
                        //debugPrint(jsonResponse.resultState)
                        
                        
                        
                        let storyboard = UIStoryboard(name: "Fahim", bundle: nil)
                        
                        if let vc = storyboard.instantiateViewController(withIdentifier: "employeeProfileVC") as? EmployeeProfileViewController {

                        vc.name =  jsonResponse.data?[0].name ?? ""
                            vc.officeName = jsonResponse.data?[0].officeName ?? ""
                            vc.personalId = jsonResponse.data?[0].personalID ?? 1
                            vc.officialContact = jsonResponse.data?[0].officialMobileNo ?? ""
                            vc.personalContact = jsonResponse.data?[0].personalContact ?? ""
                            vc.officeEmail = jsonResponse.data?[0].officialEMailID ?? ""
                            vc.personalEmail = jsonResponse.data?[0].pernonalEmail ?? ""
                            vc.presentAddress = jsonResponse.data?[0].permanentAddress ?? ""


                            self.navigationController?.pushViewController(vc, animated: true)
                            print(".....")
                        }

                        
                    }
                    
                    
                    hud.dismiss(animated: true)
                }
            }
        }.resume()
    }
    

    //edit by : Mamun issue Solve search icon and navcolor
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        customNavigationBar(navBarBackColor: navBarBackColor)
        navigationItem.rightBarButtonItem = rightItem
        
        
      
    }

}



extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainCategory?.data?.count ?? 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.homeCollectionLabel.text = listhome.home?[indexPath.row].name ?? ""
        cell.homeCollectionLabel.font = UIFont(name: "Roboto", size: 19.0)
        cell.homeCollectionImageView.image = listhome.home?[indexPath.row].image
        
        return cell
    }
    
    // edit by: mamun
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfItemPerRow: CGFloat = 2
        
        let interItemSpacing: CGFloat = 10
        
        let width = (homeCollectionView.frame.width - (numberOfItemPerRow - 1) * interItemSpacing) / numberOfItemPerRow
        
        return CGSize(width: width, height:200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row <= 5 {
            //print("hello i am inside ")
            let storyboard = UIStoryboard(name: "Badhon", bundle: nil)
            
            let vc:FirstMenuViewController =  storyboard.instantiateViewController(withIdentifier: "FirstMenuViewController") as! FirstMenuViewController
            
            guard let id = listhome.home?[indexPath.row].id else {
                return
            }
            vc.id = id
            vc.homeIndexPathRow = indexPath.row
            vc.imageName = listhome.home?[indexPath.row].image
            
            // #####################
            // edit by: mamun
            
            for i in 0 ..< HomeViewController.navbackgroudColor.count{
                if indexPath.row == HomeViewController.indexnavigation[i]{
                    vc.navBarBackColor = HomeViewController.navbackgroudColor[i]
                }
            }
            navigationController?.pushViewController(vc, animated: true)
        }
            
        
        else if indexPath.row == 6 {
            
            print("Zonal Operation")
            let storyboard = UIStoryboard(name: "Badhon", bundle: nil)
            let vc:ZonalOperationViewController = storyboard.instantiateViewController(withIdentifier: "ZonalOperationViewController") as! ZonalOperationViewController
            vc.imageName = listhome.home?[indexPath.row].image
            vc.navBarBackColor = "05AA47"
            navigationController?.pushViewController(vc, animated: true)
        }
            
        else if indexPath.row > 6 {
            
            print("project office")
            if let vc = storyboard?.instantiateViewController(withIdentifier: "PlaningViewController") as? ProjectOfficeViewController {
                vc.imageName = listhome.home?[indexPath.row].image
                vc.navBarBackColor = "C56114"
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}


extension HomeViewController{
    
    @objc func leftNavigationItemClicked() {
        
        DispatchQueue.main.async {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Fahim", bundle:nil)
            if let vc = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController {
                
                let transition = CATransition()
                transition.duration = 0.32
                
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromLeft
                
                self.navigationController?.view.layer.add(transition, forKey: kCATransition)
                
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    
    
    @objc func rightSearchNavigationItemClicked() {
        
        let storyboard = UIStoryboard(name: "Fahim", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "searchEmployeesTableVC") as? SearchEmployeesTableViewController {
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}



extension HomeViewController {
    
    func getHomeMenu(token: String) {
        
        guard let loginUrl = URL(string: UrlManager.baseURL() + "rhd/GetMainCategory") else { return }
        
        var request = URLRequest(url: loginUrl)
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.timeoutInterval = .infinity
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                if let response = response as? HTTPURLResponse, response.isResponseOK() {
                    
                    guard let data = data else {
                        print(String(describing: error))
                        return
                    }
                    
                    if let jsonResponse = try? JSONDecoder().decode(CategoryBase.self, from: data) {
                        
                        //make a json type variable ande store response here
                        
                        self.mainCategory = jsonResponse
                        
                    }
                    
                    hud.dismiss(animated: true)
                }
            }
        }.resume()
    }
}




// api request

extension HomeViewController {
    
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
                        
                       // print(defaults.string(forKey: "token")!) //SAVED TOKEN
                        
                        loginData = jsonResponse
                        
                        let profileData = OtpViewController()
                        let allData = profileData.getlogData()?.data?.user?[0]
                        self.getPhoto(personalId: allData?.personalID ?? 0)
                        
                    }
                    hud.dismiss(animated: true)
                    self.view.isUserInteractionEnabled = true
                }
            }
        }.resume()
    }
}
