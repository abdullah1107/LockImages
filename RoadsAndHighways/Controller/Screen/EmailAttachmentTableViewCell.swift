//
//  EmailAttachmentTableViewCell.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 26/8/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class EmailAttachmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var attachmentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        attachmentImageView.contentMode = .scaleToFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
