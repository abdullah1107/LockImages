//
//  TechnicalViewControllerDesign.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 12/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

extension ThirdMenuViewController{
    func setupTableView(){
        thirdMenuTableView.delegate = self
        thirdMenuTableView.dataSource = self
        // let nib = UINib(nibName: "ItemTableViewCell", bundle: nil)
        thirdMenuTableView.register(UINib(nibName: "SimpleTableViewCell", bundle: nil), forCellReuseIdentifier: "simpleCell")
    }
}

extension ThirdMenuViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabLeData?.data?.count ?? 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = thirdMenuTableView.dequeueReusableCell(withIdentifier: "simpleCell", for: indexPath) as! SimpleTableViewCell
        cell.simpleCellLabel.text = tabLeData?.data?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "ThirdMenuViewController") as! ThirdMenuViewController
//        guard let id = tabLeData?.data?[indexPath.row].cOMPID else {return}
//        vc.id = id
//        navigationController?.pushViewController(vc, animated: true)
      
        newId = tabLeData?.data?[indexPath.row].cOMPID ?? 9
        
        
        checkingTableData(token: "\(defaults.string(forKey: "token")!)")
        
        
        
    }
    
    
}


extension ThirdMenuViewController {
    
    func checkingTableData(token: String) {
        
        guard let loginUrl = URL(string: UrlManager.baseURL() + "rhd/GetNextCategoryByParent?parent=\(newId)") else { return }
        
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
                        
                        
                        self.newTableData = jsonResponse
                        
                       // print("tableData : ", self.newTableData?.data?.count)
                      //  print(self.newTableData?.resultState)
                        
                        if (self.newTableData?.resultState!)!{
                            print("if condition Worked")
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondMenuViewController") as! SecondMenuViewController
                            vc.id = self.newId
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        else{
                            print("else condition Worked")
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeListViewController") as! EmployeeListViewController
                            vc.id = self.newId
                            vc.homeIndexPathRow = self.homeIndexPathRow
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                        
                    }
                    
                    hud.dismiss(animated: true)
                }
            }
        }.resume()
    }
}





