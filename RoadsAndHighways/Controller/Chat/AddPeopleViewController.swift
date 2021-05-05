//
//  AddPeopleViewController.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 22/10/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

var namesForChat = [String]()
var idsForChat = [Int]()

class AddPeopleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var tableData : Employee?
    var groupName = String()

    @IBOutlet weak var AllemployeeTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.textColor = .blue
        self.showSimpleHUD(hudView: self.view)
        getSearchedData(keyword: "")
        AllemployeeTableView.delegate = self
        AllemployeeTableView.dataSource = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add to chat", style: .plain, target: self, action: #selector(goToChatListWithAddedUser))
        
        
    }
    
    
    @objc func goToChatListWithAddedUser() {
        
        if namesForChat.count >= 2 {
            
            let alertController = UIAlertController(title: "Add Group Name", message: "", preferredStyle: .alert)

            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter First Name"
            }
            
            let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
                
                self.groupName = alertController.textFields![0].text ?? "New Group"
                
                namesForChat.append((loginData?.data?.user?[0].name!)!)
                idsForChat.append((loginData?.data?.user?[0].Dst_COMPID)!)
                
                self.postDataToFirebase()
                
                namesForChat.removeAll()
                idsForChat.removeAll()
                
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Fahim", bundle: nil)
                    if let vc = storyboard.instantiateViewController(withIdentifier: "ChatListVC") as? ChatListViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }

            })

            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )

            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)

            self.present(alertController, animated: true, completion: nil)
        }
        
        if namesForChat.count == 1 {
            namesForChat.append((loginData?.data?.user?[0].name!)!)
            idsForChat.append((loginData?.data?.user?[0].Dst_COMPID)!)
            
            postDataToFirebase()
            namesForChat.removeAll()
            idsForChat.removeAll()
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Fahim", bundle: nil)
                if let vc = storyboard.instantiateViewController(withIdentifier: "ChatListVC") as? ChatListViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}




extension AddPeopleViewController:UISearchBarDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?.data?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AllEmployeeTableViewforChatCell = AllemployeeTableView.dequeueReusableCell(withIdentifier: "AllEmployeelist", for: indexPath) as! AllEmployeeTableViewforChatCell
        
        cell.employeeName.text = tableData?.data?[indexPath.row].name
        cell.userIdLabel.text = String(((tableData?.data?[indexPath.row].dst_COMPID) ?? 0))
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        namesForChat.append((tableData?.data?[indexPath.row].name)!)
        idsForChat.append((tableData?.data?[indexPath.row].dst_COMPID) ?? 0)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        namesForChat.removeAll { $0 == "\(tableData?.data?[indexPath.row].name ?? "")" }
        idsForChat.removeAll { $0 == tableData?.data?[indexPath.row].dst_COMPID }
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
                            
                            self.tableData = jsonResponse
        
                        }
                        self.AllemployeeTableView.reloadData()
                        
                        hud.dismiss(animated: true)
                    }
                }
            }.resume()
        }
    }



// post data to firestore
extension AddPeopleViewController {
    
    func postDataToFirebase() {
        
        let document = db.collection("chat_room").document()
        
        document.setData([
            
            "created_at": NSDate.now,
            "created_by": idsForChat.last!,
            "groupChat": false,
            "last_message": NSNull(),
            "title": groupName,
            "uid": document.documentID,
            "updated_at": NSDate.now,
            "user_id": prepareUserIds(),
            "user_name": prepareUserNames()
            
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(document.documentID)")
            }
        }
    }
}



// helper functions
extension AddPeopleViewController {
    
    func prepareUserNames() -> [String: String] {

        var userNameForChat: [String: String] = [:]
        let idsInStrings = idsForChat.map(String.init)

        for (key, value) in idsInStrings.enumerated() {
            userNameForChat[value] = namesForChat[key]
        }
        return userNameForChat
    }
    
    
    func prepareUserIds() -> [String: Bool] {
        
        var userIdsForChat: [String: Bool] = [:]
        let idsInStrings = idsForChat.map(String.init)
        
        for key in idsInStrings {
            userIdsForChat[key] = true
        }
        
        return userIdsForChat
    }
}
