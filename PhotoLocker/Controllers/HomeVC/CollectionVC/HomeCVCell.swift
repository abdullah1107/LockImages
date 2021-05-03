
//  HomeCVCell.swift
//  PhotoLocker
//  Created by Muhammad Abdullah Al Mamun on 20/4/21.


import UIKit


protocol CellDelegateCV: class {
    
    func optionButtonCV(index: Int)
}


class HomeCVCell: UICollectionViewCell {
    
    
    @IBOutlet weak var customView: UIView!
    
    @IBOutlet weak var centerImage: UIImageView!
    
    @IBOutlet weak var folderName: UILabel!
    
    @IBOutlet weak var totalDocuments: UILabel!
    
    weak var cellDelegate: CellDelegateCV?
    
    @IBOutlet weak var optionButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK:- Option Button Action
    
    @IBAction func threedotButtonAction(_ sender: UIButton) {
        
       cellDelegate?.optionButtonCV(index: sender.tag)
    }

}
