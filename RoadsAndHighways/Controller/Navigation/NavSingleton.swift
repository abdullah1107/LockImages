//
//  NavSingleton.swift
//  RoadsAndHighways
//
//  Created by Muhammad Abdullah Al Mamun on 11/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import Foundation
import  UIKit


//SingleTon
class Navigation{
    
    static let shared = Navigation()
    private init(){}
    
    func setNavigation() {
        
    }
    
    func popNavigation() {
        
    }
    
    func setNavigationHidden(navigationController:UINavigationController, animated:Bool){
        navigationController.setNavigationBarHidden(true, animated: animated)
    }
    
    func setRootViewController(){
        
    }
    
    func nextViewController(){
        
    }
    
    func nextViewControllerwithID(stroyBoardID:String, storyBoardName:String, navigationController:UINavigationController) {
        
        let storyboard = UIStoryboard(name: "\(stroyBoardID)", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "\(storyBoardName)")
            
        navigationController.pushViewController(vc, animated: true)
       
    }
}
