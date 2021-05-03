//
//  OptionCell.swift
//  PhotoLocker
//
//  Created by Muhammad Abdullah Al Mamun on 24/4/21.
//

import UIKit

class OptionCell: UITableViewCell {
    
    

    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var imageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
