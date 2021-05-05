//
//  BridgeViewController.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 10/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class EmployeeListViewController: UIViewController, UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIToolbarDelegate {
 
    var tabLeData : Employee?
    var pickerData : designation?
    var id = 217
    var navBarBackColor = String()
    
    let picker = UIPickerView()
    var toolBar = UIToolbar()
    
    var homeIndexPathRow = Int()
    
    var employeeProfileImage = UIImage()
    
    @IBOutlet weak var employeeListTableView: UITableView!
    
    @IBOutlet weak var bottomButtonStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabLeData = nil
        setuptableview()
        navColorPassFromHome()
        navigationFilterButton()
        customNavigationBar(navBarBackColor: navBarBackColor)
        
        setupLongPressGestureToSelect()
        
        DispatchQueue.main.async {
            
            self.showSimpleHUD(hudView: self.view)
        }
        
        getPickerData(token: "\(defaults.string(forKey: "token")!)")
        gettableData(token:"\(defaults.string(forKey: "token")!)")
    }
    
    @IBAction func sendSmsAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Badhon", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "HalfViewController") as? SMSViewController {
            vc.modalPresentationStyle = UIModalPresentationStyle.custom
            vc.transitioningDelegate = self
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
    
    
    func setupLongPressGestureToSelect() {
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPressToSelect(_:)))
        longPressGesture.minimumPressDuration = 1.0 // 1 second press
        longPressGesture.delegate = self
        self.employeeListTableView.addGestureRecognizer(longPressGesture)
    }
    
    
    @objc func handleLongPressToSelect(_ gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: self.employeeListTableView)
            if let indexPath = employeeListTableView.indexPathForRow(at: touchPoint) {
                
                if let cell = employeeListTableView.cellForRow(at: indexPath) {
                    cell.accessoryType = .checkmark
                    
                    phoneNumberForSms.append((tabLeData?.data?[indexPath.row].personalContact) ?? "")
                    emailAddressForEmail.append(tabLeData?.data?[indexPath.row].pernonalEmail ?? "")
                }
            }
        }
    }

    
    
    // picker
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData?.data?.count ?? 20
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            
            return self.pickerData?.data?[row].datumDescription
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

            id = (self.pickerData?.data?[row].compid)!
            
        }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
}



extension EmployeeListViewController {
    
    // get all data
    func gettableData(token: String) {
        
        guard let employeeListUrl = URL(string: UrlManager.baseURL() + "rhd/GetEmployeeListByOfficeID?officeId=\(id)") else { return }
        
        var request = URLRequest(url: employeeListUrl)
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
                    
                    if let jsonResponse = try? JSONDecoder().decode(Employee.self, from: data) {
                        
                        self.tabLeData = jsonResponse
                    }
                    self.employeeListTableView.reloadData()
                    
                    hud.dismiss(animated: true)
                }
            }
        }.resume()
    }
    
    
    // get picker data
    func getPickerData(token: String) {
        
        guard let employeeListUrl = URL(string: UrlManager.baseURL() + "rhd/GetDesignation?isExisting=1") else { return }
        
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
                        print(String(describing: error))
                        return
                    }
                    
                    if let jsonResponse = try? JSONDecoder().decode(designation.self, from: data) {
                        
                        print(jsonResponse)
    
                        self.pickerData = jsonResponse
                    }
                    
                    hud.dismiss(animated: true)
                }
            }
        }.resume()
    }
}



// right nav filer button
extension EmployeeListViewController {
    
    func navigationFilterButton() {
        
        let rightItem = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self,action: #selector(rightNavigationFilterButtonClicked))
        self.navigationItem.rightBarButtonItem  = rightItem
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    
    @objc func rightNavigationFilterButtonClicked() {
        
        // picker
        
        picker.isHidden = false
        toolBar.isHidden = false
        
        picker.dataSource = self
        picker.delegate = self
        toolBar.delegate = self
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(picker)
        
        picker.setValue(UIColor.systemGreen, forKey: "textColor")
        picker.setValue(UIColor.black, forKey: "backgroundColor")

        picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: bottomButtonStackView.topAnchor, constant: 0).isActive = true
        
        
        // picker toolbar
        toolBar = UIToolbar(frame: CGRect(x: 0, y: (view.frame.height - picker.frame.height) - (self.navigationController?.navigationBar.frame.height)! - 40, width: self.view.frame.size.width, height: 40))
        
        toolBar.barStyle = UIBarStyle.black
        toolBar.isTranslucent = false
        toolBar.tintColor = UIColor.systemGreen
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(EmployeeListViewController.donePicker(sender:)))
        
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        self.view.addSubview(toolBar)
    }
    
    @objc func donePicker(sender: UIBarButtonItem) {
        
        print(#function)
        picker.isHidden = true
       
        toolBar.removeFromSuperview()
        toolBar.isHidden = true
        gettableData(token:"\(defaults.string(forKey: "token")!)")
    }
}




// color func

extension EmployeeListViewController {
    
    func navColorPassFromHome()  {
        
        if homeIndexPathRow == 0 {
            navBarBackColor = "16A0FB"
        }
        if homeIndexPathRow == 1 {
            navBarBackColor = "00A14B"
        }
        if homeIndexPathRow == 2 {
            navBarBackColor = "E87B13"
        }
        if homeIndexPathRow == 3 {
            navBarBackColor = "16A0FB"
        }
        if homeIndexPathRow == 4 {
            navBarBackColor = "9A3FE0"
        }
        if homeIndexPathRow == 5 {
            navBarBackColor = "D72A0A"
        }
        if homeIndexPathRow == 6 {
            navBarBackColor = "05AA47"
        }
        if homeIndexPathRow == 6 {
            navBarBackColor = "C56114"
        }
    }
}

