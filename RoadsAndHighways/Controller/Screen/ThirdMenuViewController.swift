//
//  TechnicalViewController.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 9/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class ThirdMenuViewController: UIViewController {

    @IBOutlet weak var employeeListButton: UIButton!
    @IBOutlet weak var thirdMenuTableView: UITableView!
    var id : Int = 0
    var tabLeData : CategoryBase?
    var newTableData : CategoryBase?
    
    var navBarBackColor = String()
    
    var newId = Int()
    
    var homeIndexPathRow = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabLeData = nil
        setupTableView()
        customNavigationBar(navBarBackColor: navBarBackColor)
        navigationHomeButton()
        buttonDesign(button: employeeListButton)
        
        DispatchQueue.main.async {
            
            self.showSimpleHUD(hudView: self.view)
        }
        gettableData(token: "\(defaults.string(forKey: "token")!)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        customNavigationBar(navBarBackColor: navBarBackColor)
    }
    
    @IBAction func employeeList(_ sender: Any) {
        
      //  Employee List ViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "EmployeeListViewController") as? EmployeeListViewController {
            
            vc.id = id
            vc.homeIndexPathRow = self.homeIndexPathRow
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    

}
extension ThirdMenuViewController {
    
    func gettableData(token: String) {
        
        guard let loginUrl = URL(string: UrlManager.baseURL() + "rhd/GetNextCategoryByParent?parent=\(id)") else { return }
        
        var request = URLRequest(url: loginUrl)
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        // request.httpBody = postData
        request.timeoutInterval = .infinity
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                if let response = response as? HTTPURLResponse, response.isResponseOK() {
                    //print(response)
                    
                    guard let data = data else {
                        print(String(describing: error))
                        return
                    }
                    
                    if let jsonResponse = try? JSONDecoder().decode(CategoryBase.self, from: data) {
                        
                        
                        self.tabLeData = jsonResponse
                        
                    }
                    self.thirdMenuTableView.reloadData()
                    
                    hud.dismiss(animated: true)
                }
            }
        }.resume()
    }
}
