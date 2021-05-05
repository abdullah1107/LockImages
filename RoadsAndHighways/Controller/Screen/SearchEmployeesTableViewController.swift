//
//  SearchEmployeesTableViewController.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 25/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class SearchEmployeesTableViewController: UIViewController, UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    var tableData: Employee?
    
    var multipleSelectionModeSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableData = nil
        setupTableView()
        searchBar.textColor = UIColor.black
        searchTableView.allowsMultipleSelection = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Selection Mode", style: .plain, target: self, action: #selector(selectMultiple))
        
        DispatchQueue.main.async {
            
            self.showSimpleHUD(hudView: self.view)
        }
        getSearchedData(keyword: "")
    }
    
    
    @objc func selectMultiple() {
        
        if multipleSelectionModeSelected {
            navigationItem.rightBarButtonItem?.title = "Selection Mode"
        }
        else {
            navigationItem.rightBarButtonItem?.title = "Normal Mode"
        }
        multipleSelectionModeSelected.toggle()
        print(multipleSelectionModeSelected)
    }
    
    
    @IBAction func sendSms(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Badhon", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "HalfViewController") as? SMSViewController {
            vc.modalPresentationStyle = UIModalPresentationStyle.custom
            vc.transitioningDelegate = self
            
            present(vc, animated: true)
        }
    }
    
    @IBAction func sendEmail(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Fahim", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "emailViewController") as? EmailViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SetSizePresentationController(presentedViewController: presented, presenting: presenting)
    }

}




extension SearchEmployeesTableViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableData?.data?.count ?? 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: EmployeeListCell = searchTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmployeeListCell
        
        cell.nameLabel.text = tableData?.data?[indexPath.row].displayName ?? ""
        cell.degination.text = tableData?.data?[indexPath.row].designation ?? ""
        cell.address.text = tableData?.data?[indexPath.row].officeName ?? ""
        
        return cell
    }
    

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if multipleSelectionModeSelected {
            
            phoneNumberForSms.append((tableData?.data?[indexPath.row].personalContact) ?? "")
            emailAddressForEmail.append(tableData?.data?[indexPath.row].pernonalEmail ?? "")

        }
        
        else {
            
            if let cell = searchTableView.cellForRow(at: indexPath) {
                cell.accessoryType = .none
        }
            
            let storyboard = UIStoryboard(name: "Fahim", bundle: nil)
            
            if let vc = storyboard.instantiateViewController(withIdentifier: "employeeProfileVC") as? EmployeeProfileViewController {
                
                vc.name = tableData?.data?[indexPath.row].name ?? ""
                vc.officeName = tableData?.data?[indexPath.row].officeName ?? ""
                vc.personalId = tableData?.data?[indexPath.row].personalID ?? 0
                vc.officialContact = tableData?.data?[indexPath.row].officialMobileNo ?? ""
                vc.personalContact = tableData?.data?[indexPath.row].personalContact ?? ""
                vc.officeEmail = tableData?.data?[indexPath.row].officialEMailID ?? ""
                vc.personalEmail = tableData?.data?[indexPath.row].pernonalEmail ?? ""
                vc.presentAddress = tableData?.data?[indexPath.row].presentAddress ?? ""
                
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

        if multipleSelectionModeSelected {
  
                phoneNumberForSms.removeAll { $0 == "\(tableData?.data?[indexPath.row].personalContact ?? "")" }
                emailAddressForEmail.removeAll { $0 == "\(tableData?.data?[indexPath.row].pernonalEmail ?? "")" }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        DispatchQueue.main.async {
            
            self.showSimpleHUD(hudView: self.view)
        }
        
        getSearchedData(keyword: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       //keyboard
        searchBar.resignFirstResponder()
     
        DispatchQueue.main.async {
            
            self.showSimpleHUD(hudView: self.view)
        }
        
        getSearchedData(keyword: searchBar.text ?? "")
    }
    
    func setupTableView() {
        
        self.searchBar.delegate = self
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
        self.searchTableView.allowsSelection = true
        self.searchTableView.register(UINib(nibName: "EmployeeListCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
}


extension SearchEmployeesTableViewController {
    
    func getSearchedData(keyword: String) {
        
        guard let searchUrl = URL(string: UrlManager.baseURL() + "rhd/SearchEmployee?keyword=\(keyword)") else { return }
        
        var request = URLRequest(url: searchUrl)
        
        request.addValue("Bearer \(defaults.string(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        
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
                        
                        
                        self.tableData = jsonResponse
                        
                    }
                    self.searchTableView.reloadData()
                    
                    hud.dismiss(animated: true)
                }
            }
        }.resume()
    }
}
