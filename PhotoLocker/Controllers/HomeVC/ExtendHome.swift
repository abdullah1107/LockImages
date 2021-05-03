//  ExtendHome.swift
//  PhotoLocker
//  Created by Muhammad Abdullah Al Mamun on 22/4/21.


import Foundation
import UIKit


extension HomeVC{
    
    
    func setCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 65 , left: 10, bottom: 40, right: 10)
        
        self.homeCV = UICollectionView(frame: CGRect(x:searchBar.frame.minX, y: searchBar.frame.minY + 20.0 , width: view.frame.width, height: view.frame.height - 60), collectionViewLayout: layout)
        
        self.homeCV.register(UINib(nibName: "HomeCVCell", bundle: nil), forCellWithReuseIdentifier: "homeCV")
        self.homeCV.backgroundColor = UIColor(named: "EEEEEE")
        
        homeCV.dataSource = self
        homeCV.delegate = self
        
        self.homeCV.showsVerticalScrollIndicator = false
        
        self.homeCV.allowsMultipleSelection = false
        
        self.view.addSubview(self.homeCV)
        self.view.sendSubviewToBack(self.homeCV)
    }
    
    
    func setCVCell(cell: UICollectionViewCell) -> UICollectionViewCell {
        
        
        //cell.contentView.layer.cornerRadius = 20.0
        //cell.contentView.layer.borderWidth = 2.0
        //cell.contentView.layer.borderColor = UIColor.clear.cgColor
//        cell.contentView.layer.masksToBounds = true
//
//        cell.layer.shadowColor = UIColor.systemGray.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        cell.layer.shadowRadius = 4.0
//        cell.layer.shadowOpacity = 0.5
//        cell.layer.masksToBounds = false
//        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        
        ///
//
       cell.layer.cornerRadius = 15.0
       cell.layer.borderColor = UIColor.systemFill.cgColor
        cell.layer.borderWidth = 1.0
        cell.layer.shadowRadius = 4.0
        //cell.layer.shadowOpacity = 0.2
        cell.clipsToBounds = true
        
        return cell
    }
    
}
