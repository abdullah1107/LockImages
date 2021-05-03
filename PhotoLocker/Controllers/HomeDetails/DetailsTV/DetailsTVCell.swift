//  DetailsTVCell.swift
//  PhotoLocker
//  Created by Muhammad Abdullah Al Mamun on 2/5/21.


import UIKit


protocol CellDelegateTV: class {
    
    func optionButtonTV(index: Int)
}

class DetailsTVCell: UITableViewCell {
    
    
    @IBOutlet weak var docsAndFoldsImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    @IBOutlet weak var optionButton: UIButton!
    
    
    @IBOutlet weak var selectIndicator: UIImageView!
    
    
    
    weak var cellDelegate: CellDelegateTV?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func optionButtonAction(_ sender: UIButton) {
        
        cellDelegate?.optionButtonTV(index: sender.tag)
    }
    
}



