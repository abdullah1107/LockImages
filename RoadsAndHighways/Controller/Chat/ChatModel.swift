//
//  ChatModel.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 23/10/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit
import MessageKit

struct Sender: SenderType {
    
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct Media: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
}
