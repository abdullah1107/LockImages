//  HomeCV.swift
//  PhotoLocker
//  Created by Muhammad Abdullah Al Mamun on 22/4/21.


import Foundation
import UIKit


extension HomeVC:UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CellDelegateCV{
    
    
    
    func optionButtonCV(index: Int) {

        if let optionVC = self.storyboard?.instantiateViewController(withIdentifier: "OptionVC") as? OptionVC{
            
            optionVC.optionIndex = index
            optionVC.primaryKey = self.folders[index].folderName ?? ""
            self.navigationController?.pushViewController(optionVC, animated: true)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return folders.count
    }
    
    
    
    // MARK: - Cell For Item At
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = homeCV.dequeueReusableCell(withReuseIdentifier: "homeCV", for: indexPath) as! HomeCVCell
        
        cell.cellDelegate = self
        
        cell.optionButton.tag = indexPath.row
      
        
        cell.centerImage.image = UIImage(data:self.folders[indexPath.row].folderData ?? Data())
        cell.folderName.text = self.folders[indexPath.row].editablefolderName
        
        cell.totalDocuments.text = String(self.folders[indexPath.row].documents.count) + " Document(s)"
        


        return self.setCVCell(cell: cell)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("indexpath:", indexPath.row)
        
        if let homeDetails = self.storyboard?.instantiateViewController(withIdentifier: "HomeDetailsVC") as? HomeDetailsVC {
            
            homeDetails.Index = indexPath.row
            homeDetails.primaryKey = folders[indexPath.row].folderName ?? ""
        
            
            self.navigationController?.pushViewController(homeDetails, animated: true)
        }
        
        
        
        
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Collection View Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfCellsInRow))
        
        return CGSize(width: size, height: size + 10)
    }
    
    
}


