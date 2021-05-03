//
//  DesignHomeDetails.swift
//  PhotoLocker
//
//  Created by Muhammad Abdullah Al Mamun on 26/4/21.
//

import Foundation
import UIKit



extension HomeDetailsVC{
    
    func setfourCollectionView(){
        
        customViewOne = UIView(frame: CGRect(x: searchBar.frame.minX, y: searchBar.frame.maxY, width: view.frame.width, height: view.frame.height))
        self.customViewOne.backgroundColor = UIColor.yellow
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.fourgridCV = UICollectionView(frame: CGRect(x: 0, y: 0, width: customViewOne.frame.width, height: customViewOne.frame.height - 270), collectionViewLayout: layout)
        
        self.fourgridCV.register(UINib(nibName: "HomeCVCell", bundle: nil), forCellWithReuseIdentifier: "homeCV")
        
        self.fourgridCV?.backgroundColor = UIColor(named: "EEEEEE")
        
        
        self.fourgridCV.dataSource = self
        self.fourgridCV.delegate = self
        fourgridCV.tag = ConfigHomeDetails.fourCVTag
        
        
        self.fourgridCV.showsVerticalScrollIndicator = false
        
        self.fourgridCV.allowsMultipleSelection = false
        
        
        if gridButtonClicked ==  ConfigHomeDetails.fourCVTag{
            self.view.addSubview(customViewOne)
            self.customViewOne.addSubview(self.fourgridCV)
            self.view.sendSubviewToBack(self.fourgridCV)
            self.view.addSubview(bottomView)
        }
        
        
        
        
    }//end of fourGrid
    
    
    func settwoCollectionView(){
        
        customViewTwo = UIView(frame: CGRect(x: searchBar.frame.minX, y: searchBar.frame.maxY, width: view.frame.width, height: view.frame.height))
        self.customViewTwo.backgroundColor = UIColor.gray
        
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.twogridCV = UICollectionView(frame: CGRect(x: 0, y: 0, width: customViewTwo.frame.width, height: customViewTwo.frame.height - 270), collectionViewLayout: layout)
        
        self.twogridCV.register(UINib(nibName: "HomeCVCell", bundle: nil), forCellWithReuseIdentifier: "homeCV")
        
        self.twogridCV?.backgroundColor = UIColor(named: "EEEEEE")
        
        
        self.twogridCV.dataSource = self
        self.twogridCV.delegate = self
        
        
        
        self.twogridCV.showsVerticalScrollIndicator = false
        
        self.twogridCV.allowsMultipleSelection = false
        
        if gridButtonClicked ==  ConfigHomeDetails.twoCVTag{
            
            customViewOne.removeFromSuperview()
            self.view.addSubview(customViewTwo)
            self.customViewTwo.addSubview(self.twogridCV)
            self.view.sendSubviewToBack(self.twogridCV)
            self.view.addSubview(bottomView)
        }
        
        
        
    }//end of Twogrid
    
    
    //-------------------------------------------------------------
    
    
    // MARK: - Set Document Collection View Cell
    
    func setCVCell(cell: UICollectionViewCell) -> UICollectionViewCell {
        
        return cell
    }
    
    
    
    
    
    func setTableView(){
        
        debugPrint("setTableView")
        customViewThree = UIView(frame: CGRect(x: searchBar.frame.minX, y: searchBar.frame.maxY, width: view.frame.width, height: view.frame.height))
        
        //self.view.addSubview(customViewThree)
        
        self.listTV.register(UINib(nibName: "DetailsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        self.listTV.frame = CGRect(x: 10, y: 0, width: customViewThree.frame.width - 20, height: customViewThree.frame.height - 270)
        
        
        self.listTV.backgroundColor = UIColor(hex: "EEEEEE")
        
        self.listTV.dataSource = self
        self.listTV.delegate = self
        
        self.listTV.showsVerticalScrollIndicator = false
        
        self.listTV.allowsMultipleSelectionDuringEditing = true
        
        if gridButtonClicked ==  ConfigHomeDetails.threeTVTag{
            
            customViewOne.removeFromSuperview()
            customViewTwo.removeFromSuperview()
            self.view.addSubview(customViewThree)
       
            self.customViewThree.addSubview(self.listTV)
            self.view.sendSubviewToBack(self.listTV)
            self.view.addSubview(bottomView)
        }
        
      
        
    }
    
    
    func setDetailsTVCell(cell: UITableViewCell) -> UITableViewCell {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        cell.multipleSelectionBackgroundView = view
        cell.backgroundColor = .white
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
       // cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
}
