//
//  ExtentionHomeViewController.swift
//  RoadsAndHighways
//  Created by Muhammad Abdullah Al Mamun on 4/12/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import Foundation
import UIKit


extension HomeViewController{
    

    static let navbackgroudColor = ["16A0FB", "00A14B", "E87B13","16A0FB", "9A3FE0", "D72A0A"]
    static let indexnavigation = [0, 1, 2, 3, 4, 5]
    
    public func setNavigation() {
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        let leftItem = UIBarButtonItem(image: UIImage(named: "menuicon"), style: .plain, target: self,action: #selector(leftNavigationItemClicked))
        
        self.navigationItem.leftBarButtonItem  = leftItem
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        rightItem = UIBarButtonItem(image: UIImage(named: "searchicon"), style: .plain, target: self,action: #selector(rightSearchNavigationItemClicked))
        
        self.navigationItem.rightBarButtonItem  = rightItem
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        navigationController?.navigationBar.barTintColor = UIColor(hex: "363A44")
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
}
