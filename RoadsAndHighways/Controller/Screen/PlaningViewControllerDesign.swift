//
//  PlaningViewControllerDesign.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 10/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

extension ProjectOfficeViewController{
    
    func setupTableView() {
        
        projectOfficeTableView.delegate = self
        projectOfficeTableView.dataSource = self
        // let nib = UINib(nibName: "ItemTableViewCell", bundle: nil)
        projectOfficeTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "tableCellIdentifier")
    }
    
}
extension ProjectOfficeViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let counter = tabLeData?.data?.count else {return 0}
        return counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = projectOfficeTableView.dequeueReusableCell(withIdentifier: "tableCellIdentifier", for: indexPath) as! ItemTableViewCell
        
        cell.tableNibLabel.text = tabLeData?.data?[indexPath.row].name
        cell.tableNibImageView.image = imageName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SecondMenuViewController") as! SecondMenuViewController
        guard let id = tabLeData?.data?[indexPath.row].cOMPID else {return}
        vc.id = id
        //vc.id = tabLeData?.data?[indexPath.row].cOMPID ?? 9
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
