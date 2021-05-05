//
//  HomeModel.swift
//  RoadsAndHighways
//
//  Created by Muhammad Abdullah Al Mamun on 11/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import Foundation
import UIKit


struct Home{
    let name:String?
    let image:UIImage?
    let id:Int
    
    init(name:String?, image:UIImage?, id:Int){
        self.name = name
        self.image = image
        self.id = id
    }
    
}

struct HomeList{
    
    var home : [Home]?
    
    init(home: [Home]) {
        self.home = home
    }
}

let listhome:HomeList = HomeList(home: [Home(name: "Chief Engineers Office", image: UIImage(named: "chefengineer"), id:628),
                                        Home(name: "Management Services", image: UIImage(named: "management"),id: 866),
                                        Home(name: "Planning and Maintenance", image: UIImage(named: "planning"), id: 9),
                                        Home(name: "Technical Service", image: UIImage(named: "technical"), id: 10),
                                        Home(name: "Bridge Management", image: UIImage(named: "bridge"), id: 867),
                                        Home(name: "Mechanical Services", image: UIImage(named: "mecanical"),id: 11),
                                        Home(name: "Zonal Operation", image: UIImage(named: "zonaloperation"), id:0005 ),
                                        Home(name: "Project Office", image: UIImage(named: "projectoffice"), id: 0006),
                                        ])



