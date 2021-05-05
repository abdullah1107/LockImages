//
//  ChatListTableViewCell.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 21/10/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var chatListIconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
