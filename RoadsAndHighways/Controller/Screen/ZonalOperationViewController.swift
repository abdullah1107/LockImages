//
//  ZonalOperationViewController.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 8/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class ZonalOperationViewController: UIViewController {
    
    @IBOutlet weak var zonalTableView: UITableView!
    
    var tabLeData : CategoryBase?
    var imageName:UIImage?
    
    var navBarBackColor = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gettableData(token: "\(defaults.string(forKey: "token")!)")
        customNavigationBar(navBarBackColor: navBarBackColor)
        zonalTableView.delegate = self
        zonalTableView.dataSource = self
        // let nib = UINib(nibName: "ItemTableViewCell", bundle: nil)
        zonalTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "tableCellIdentifier")
        self.navigationItem.rightBarButtonItem = nil
    }
    
    
    
    
}
extension ZonalOperationViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let counter = tabLeData?.data?.count else {return 0}
        return counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = zonalTableView.dequeueReusableCell(withIdentifier: "tableCellIdentifier", for: indexPath) as! ItemTableViewCell
        
        cell.tableNibLabel.text = tabLeData?.data?[indexPath.row].name
        cell.tableNibImageView.image = imageName
        //cell.imageView?.image = UIImage(named: "zonaloperation")
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SecondMenuViewController") as! SecondMenuViewController
        vc.id = tabLeData?.data?[indexPath.row].cOMPID ?? 9
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
extension ZonalOperationViewController {
    
    func gettableData(token: String) {
        
        guard let loginUrl = URL(string: UrlManager.baseURL() + "rhd/GetZonalOperation") else { return }
        
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
                    self.zonalTableView.reloadData()
                    
                    hud.dismiss(animated: true)
                }
            }
        }.resume()
    }
}
