//
//  ChatViewController.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 23/10/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit
import FirebaseFirestore
import MessageKit
import InputBarAccessoryView
import FirebaseStorage

class ChatViewController: MessagesViewController {
    
    // variables
    var uid = String()
    var userName = loginData?.data?.user?[0].name ?? ""
    var userId = loginData?.data?.user?[0].Dst_COMPID
    var messages = [MessageType]()
    //var chatImageUrl = UIImage()
    let baseUrlforFirStorageFile = "gs://rhd-app-8bc71.appspot.com/"
    var messengerImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegates and datasources
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        // removing the avater from ingoing and outcoming chat
        removeAvater()
        // getting messages from firestore database
        gettingMessagesFromDatabase()
    }
}




// implementation of getting messages from firestore
extension ChatViewController {
    
    func gettingMessagesFromDatabase() {
        
        db.collection("chat_room").document(uid).collection("messages").order(by: "date").addSnapshotListener { [self] (snap, error) in
            
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges {
                
                if i.type == .added {
                    
                    if i.document.get("file") as? [String: String] != nil {
                        
                        guard let filepath = i.document.get("file") as? [String: String] else { return }
                        
                        getImageDataFromFire(url: baseUrlforFirStorageFile + "\(filepath["path"]!)")
                        
                        print("//", self.messengerImage)
                        
                        self.messages.append(Message(sender: Sender(
                                                        senderId: "\(i.document.get("user_id")!)",
                                                        displayName: i.document.get("user_name") as! String),
                                                     messageId: i.document.get("user_name") as! String,
                                                     sentDate: (i.document.get("date") as! Timestamp).dateValue(),
                                                     kind: .photo(Media(
                                                                    url: nil,
                                                                    image: nil,
                                                                    placeholderImage: self.messengerImage,
                                                                    size: CGSize(width: 200, height: 200)))
                        ))
                    }
                    
                    else {
                        
                        self.messages.append(Message(sender: Sender(
                                                        
                                                        senderId: "\(i.document.get("user_id")!)",
                                                        displayName: i.document.get("user_name") as! String),
                                                     messageId: i.document.get("user_name") as! String,
                                                     sentDate: (i.document.get("date") as! Timestamp).dateValue(),
                                                     kind: .text(i.document.get("text") as! String)
                        ))
                    }
                    
                    DispatchQueue.main.async {
                        self.messagesCollectionView.reloadData()
                        self.messagesCollectionView.scrollToBottom()
                    }
                }
            }
        }
    }
}







// implementation of chat view controller
extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, MessageCellDelegate {
    
    // sender id and name
    func currentSender() -> SenderType {
        return Sender(senderId: "\(self.userId ?? 0)", displayName: self.userName)
    }
    
    // messages got from firestore
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    // number of chat bubbles
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    // background of incoming and outgoing chat bubbles
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .darkGray : .systemIndigo
    }
    
    // name label size
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 35
    }
    
    // name label text
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        return NSAttributedString(string: message.sender.displayName, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
    }
    
    // date and time label size
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 25
    }
    
    // date and time label text
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
    }
    
    // hiding the avater view
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.isHidden = true
    }
    
    // setting the size of the avater view
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    // setting chat bubble position and style
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return  MessageStyle.bubbleTail(corner, .pointedEdge)
    }
}







// implementation of message input bar and posting messages to the firestore
extension ChatViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        if !inputBar.inputTextView.text.isEmpty {
            
            let document = db.collection("chat_room").document(uid).collection("messages").document()
            
            document.setData([
                
                "date": NSDate.now,
                "text": "\(inputBar.inputTextView.text!)",
                "user_id": userId ?? 0,
                "user_name": userName,
                "file": NSNull(),
                "read_time": NSNull(),
                "is_deleted": false
                
            ]) { (err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
            }
        }
        inputBar.inputTextView.text = "" // making text field empty when send button is pressed
    }
}







// various helping methods
extension ChatViewController {
    
    // implementation for removing avater and repositioning the name and timeDate label
    func removeAvater() {
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            
            // setting avater size to zero for texts, photos and others
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
            layout.setMessageIncomingAvatarSize(.zero)
            layout.setMessageOutgoingAvatarSize(.zero)
            
            // top incoming label aka nameLabel
            messagesCollectionView.messagesCollectionViewFlowLayout.setMessageIncomingMessageTopLabelAlignment(LabelAlignment(textAlignment: .left, textInsets: .init(top: 0, left: 10, bottom: 0, right: 0)))
            //top outgoing label aka nameLabel
            messagesCollectionView.messagesCollectionViewFlowLayout.setMessageOutgoingMessageTopLabelAlignment(LabelAlignment(textAlignment: .right, textInsets: .init(top: 0, left: 0, bottom: 0, right: 10)))
            
            // bottom incoming label aka timeDate label
            messagesCollectionView.messagesCollectionViewFlowLayout.setMessageIncomingMessageBottomLabelAlignment(LabelAlignment(textAlignment: .left, textInsets: .zero))
            // bottom outgoing label aka timeDate label
            messagesCollectionView.messagesCollectionViewFlowLayout.setMessageOutgoingMessageBottomLabelAlignment(LabelAlignment(textAlignment: .right, textInsets: .zero))
        }
    }
    
    
    func getImageDataFromFire(url: String) {
        
        let storage = Storage.storage()
        var reference: StorageReference!
        reference = storage.reference(forURL: url)
        
        reference.downloadURL { url, _ in
            
            if let data = NSData(contentsOf: url!) {
                self.messengerImage = UIImage(data: data as Data) ?? UIImage()
                print("ins", self.messengerImage)
            }
        }
    }
}
