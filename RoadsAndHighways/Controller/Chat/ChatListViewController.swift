//
//  ChatListViewController.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 21/10/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class ChatListViewController: UIViewController {

    @IBOutlet weak var chatListTableView: UITableView!
    
    var chatListdata = [ChatListData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Chat Now"
        
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        
        chatListTableView.tableFooterView = UIView()
        
        getPeopleListDataFromFirestore()
        
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add New", style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped(){
     
        let storyboard = UIStoryboard(name: "Fahim", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddPeopleViewController") as! AddPeopleViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.chatListdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "chatListCell", for: indexPath) as? ChatListTableViewCell {
            
            guard let names = self.chatListdata[indexPath.row].username as? [String: String] else { return cell }
            
            if names.count <= 2 {
                    
                cell.nameLabel.text = names.first?.value
                cell.chatListIconImage.image = UIImage(named: "profileIcon")
            }
            
            if names.count > 2 {
                
                guard let title = self.chatListdata[indexPath.row].title as? String else { return cell }
            
                    cell.chatListIconImage.image = UIImage(named: "chatGroup")
                    cell.nameLabel.text = title
            }
            
            
            
            guard let lastMessage = self.chatListdata[indexPath.row].lastMessage as? String else { return cell }
            
            cell.lastMessageLabel.text = lastMessage

            return cell
        }
        return UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Fahim", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "chatVC") as? ChatViewController {
                self.navigationController?.pushViewController(vc, animated: true)
                
                vc.uid = self.chatListdata[indexPath.row].uid!
    
            }
        }
    }
}




extension ChatListViewController {
    
    func getPeopleListDataFromFirestore() {
        
        db.collection("chat_room").addSnapshotListener { [self] (snap, error) in
            
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges {
                
                if i.type == .added {
                
                    let isGroupChat = i.document.get("groupChat") as Any
                    let lastMessage = i.document.get("last_message") as Any
                    let userId = i.document.get("user_id") as Any
                    let username = i.document.get("user_name") as Any
                    let title = i.document.get("title") as Any
                    let uid = i.document.get("uid") as? String
                    
                    let data = ChatListData(lastMessage: lastMessage, username: username, isGroupChat: isGroupChat, userId: userId, title: title, uid: uid)
                    
                    DispatchQueue.main.async {
                        self.chatListdata.append(data)
                        self.chatListTableView.reloadData()
                    }
                }
            }
        }
    }
}
