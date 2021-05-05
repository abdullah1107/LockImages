//
//  PlaningViewController.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 10/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class ProjectOfficeViewController: UIViewController {
    
    
    var imageName:UIImage?
    @IBOutlet weak var projectOfficeTableView: UITableView!
    
    var tabLeData : CategoryBase?
    
    var navBarBackColor = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabLeData = nil
        setupTableView()
        customNavigationBar(navBarBackColor: navBarBackColor)
        gettableData(token: "\(defaults.string(forKey: "token")!)")
        self.navigationItem.rightBarButtonItem = nil
    }
}

extension ProjectOfficeViewController {
    
    func gettableData(token: String) {
        
        guard let loginUrl = URL(string: UrlManager.baseURL() + "rhd/GetProjectOffice?isExisting=1") else { return }
        
        var request = URLRequest(url: loginUrl)
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        // request.httpBody = postData
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
                        
                        
                        self.tabLeData = jsonResponse
                        // print(self.tabLeData)
                        
                    }
                    self.projectOfficeTableView.reloadData()
                    
                    hud.dismiss(animated: true)
                }
            }
        }.resume()
    }
}
