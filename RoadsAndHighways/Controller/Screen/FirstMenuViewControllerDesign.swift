//
//  ChiefEngineersViewControllerDesign.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 11/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

extension FirstMenuViewController{
    func setupTableView(){
        FirstMenuTableView.delegate = self
        FirstMenuTableView.dataSource = self
        FirstMenuTableView.showsVerticalScrollIndicator = false
    }
    
}

extension FirstMenuViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let counter =  tabLeData?.data?.count  else { return 0}
        return counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FirstMenuTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FirstMenuTableViewCell
        cell.chefTableCellLabel.text = tabLeData?.data?[indexPath.row].name
        cell.firstCellImage.image = imageName
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //        guard let resultState = tabLeData?.resultState else {return}
        // print(state)
        newId = tabLeData?.data?[indexPath.row].cOMPID ?? 9
        checkingTableData(token: "\(defaults.string(forKey: "token")!)")
        
        
        
        
        
//
//        if let counter = tabLeData?.data?.count{
//
//            print("@@@@@@@@",counter)
//
//            if counter > 0 {
//                print("inside NULL")
//                let vc = storyboard?.instantiateViewController(withIdentifier: "FirstMenuViewController") as! FirstMenuViewController
//                guard let id =  tabLeData?.data?[indexPath.row].cOMPID else {
//                    return
//                }
//
//                vc.id = id
//                vc.imageName = imageName
//                navigationController?.pushViewController(vc, animated: true)
//            }
//        }
        
        
        
        
        
        
        //        else if (resultState == false){
        //            if let vc = storyboard?.instantiateViewController(withIdentifier: "EmployeeListViewController") as? EmployeeListViewController {
        //
        //                 vc.id = id
        //                 navigationController?.pushViewController(vc, animated: true)
        //             }
        //           }
    }
    
    
    
}

extension FirstMenuViewController {
    
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
                            vc.homeIndexPathRow = self.homeIndexPathRow
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
