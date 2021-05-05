//
//  ChiefEngineersViewController.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 11/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class FirstMenuViewController: UIViewController {

    @IBOutlet weak var employeeListButton: UIButton!
    @IBOutlet weak var FirstMenuTableView: UITableView!
    
    var id : Int = 0
    var tabLeData : CategoryBase?
    var newTableData : CategoryBase?

    var newId = Int()
    var imageName: UIImage?
    
    var navBarBackColor = String()
    
    var homeIndexPathRow = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabLeData = nil
        setupTableView()
        customNavigationBar(navBarBackColor: navBarBackColor)
        navigationHomeButton()
        buttonDesign(button: employeeListButton)
        
        print(id)
        
        DispatchQueue.main.async {
            
            self.showSimpleHUD(hudView: self.view)
        }
        guard  let tokenValue = defaults.string(forKey: "token") else {
            return
        }
        gettableData(token: "\(tokenValue)")
        
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

extension FirstMenuViewController {
    
    func gettableData(token: String) {
        
        guard let loginUrl = URL(string: UrlManager.baseURL() + "rhd/GetNextCategoryByParent?parent=\(id)") else { return }
        
        var request = URLRequest(url: loginUrl)
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
                    
                    if let jsonResponse = try? JSONDecoder().decode(CategoryBase.self, from: data) {
                        
                        print(jsonResponse)
                     
                        self.tabLeData = jsonResponse
                        
                    }
                    self.FirstMenuTableView.reloadData()
                    
                    hud.dismiss(animated: true)
                }
            }
        }.resume()
    }
}
