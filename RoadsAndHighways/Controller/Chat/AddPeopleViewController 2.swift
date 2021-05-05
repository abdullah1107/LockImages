//
//  AddPeopleViewController.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 22/10/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class AddPeopleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var tableData : Employee?

    @IBOutlet weak var AllemployeeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.textColor = .blue
        self.showSimpleHUD(hudView: self.view)
        getSearchedData(keyword: "")
        AllemployeeTableView.delegate = self
        AllemployeeTableView.dataSource = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add to chat", style: .plain, target: self, action: #selector(goToChat))
    }
    
    
    @objc func goToChat() {
        print("go to chat page")
    }

}




extension AddPeopleViewController:UISearchBarDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?.data?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AllEmployeeTableViewforChatCell = AllemployeeTableView.dequeueReusableCell(withIdentifier: "AllEmployeelist", for: indexPath) as! AllEmployeeTableViewforChatCell
        
        cell.employeeName.text = tableData?.data?[indexPath.row].name
        cell.userIdLabel.text = tableData?.data?[indexPath.row].empID
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        DispatchQueue.main.async {
            
            self.showSimpleHUD(hudView: self.view)
        }
        
        getSearchedData(keyword: searchText)
    }
    
}

extension AddPeopleViewController{
        
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
                            print(jsonResponse)
                            
                            self.tableData = jsonResponse
                            
                        }
                        self.AllemployeeTableView.reloadData()
                        
                        hud.dismiss(animated: true)
                    }
                }
            }.resume()
        }
    }
