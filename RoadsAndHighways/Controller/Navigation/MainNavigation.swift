//
//  MainNavigation.swift
//  RoadsAndHighways
//
//  Created by Muhammad Abdullah Al Mamun on 15/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class MainNavigation: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor(hex: "00A14B")
                  self.navigationBar.tintColor = UIColor.white
                  self.navigationBar.isTranslucent = false
                  self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        // Do any additional setup after loading the view.
    }
    

}
