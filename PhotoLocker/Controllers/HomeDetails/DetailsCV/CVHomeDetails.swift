//  CVHomeDetails.swift
//  PhotoLocker
//  Created by Muhammad Abdullah Al Mamun on 26/4/21.

import Foundation
import UIKit

extension HomeDetailsVC:UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CellDelegateCV{
    
    
    func optionButtonCV(index: Int) {
        debugPrint("CVIndex:",index)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.fourgridCV{
            return 35
        }else if (collectionView == self.twogridCV){
           
            return 20
        }
        
        return Int()
 
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.fourgridCV{
            
            let cell = fourgridCV.dequeueReusableCell(withReuseIdentifier: "homeCV", for: indexPath) as! HomeCVCell
            
            cell.cellDelegate = self
            cell.folderName.text = "Defaults"
            
            cell.optionButton.tag = indexPath.row
            
            
            return cell
        
            
        }else if (collectionView == self.twogridCV){
 
            let cell = twogridCV.dequeueReusableCell(withReuseIdentifier: "homeCV", for: indexPath) as! HomeCVCell
            
            
            
            cell.cellDelegate = self
            cell.folderName.text = "Hello"
            
            cell.optionButton.tag = indexPath.row
            
            
            return cell
            
        }
        
        
        return UICollectionViewCell()
        
    }
    
    // MARK: - Collection View Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         var cellsAcross:CGFloat = 0

        if collectionView == self.fourgridCV{
            cellsAcross = 3.0
        }else{
            self.fourgridCV.removeFromSuperview()
            cellsAcross = 2.0
        }

        let spaceBetweenCells: CGFloat = 1
        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross

        return CGSize(width: dim, height: dim + 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    
}
