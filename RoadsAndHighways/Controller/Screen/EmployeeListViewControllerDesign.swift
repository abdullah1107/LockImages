//
//  BridgeViewControllerDesign.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 10/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

extension EmployeeListViewController {
    
    func setuptableview(){
        employeeListTableView.delegate = self
        employeeListTableView.dataSource = self
        employeeListTableView.register(UINib(nibName: "EmployeeListCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}
extension EmployeeListViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            if let cell = employeeListTableView.cellForRow(at: indexPath) {
                cell.accessoryType = .none
                
                phoneNumberForSms.removeAll { $0 == "\(tabLeData?.data?[indexPath.row].personalContact ?? "")" }
                emailAddressForEmail.removeAll { $0 == "\(tabLeData?.data?[indexPath.row].pernonalEmail ?? "")" }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabLeData?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:EmployeeListCell = employeeListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmployeeListCell
        cell.nameLabel.text = tabLeData?.data?[indexPath.row].displayName ?? ""
        cell.degination.text = tabLeData?.data?[indexPath.row].designation ?? ""
        cell.address.text = tabLeData?.data?[indexPath.row].officeName ?? ""
        
        cell.getEmployeePhoto(personalId: tabLeData?.data?[indexPath.row].personalID ?? 0)
        
        phoneNumberForSms.append((tabLeData?.data?[indexPath.row].personalContact) ?? "")
        emailAddressForEmail.append(tabLeData?.data?[indexPath.row].pernonalEmail ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let storyboard = UIStoryboard(name: "Fahim", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "employeeProfileVC") as? EmployeeProfileViewController {
            
            vc.name = tabLeData?.data?[indexPath.row].name ?? ""
            vc.officeName = tabLeData?.data?[indexPath.row].officeName ?? ""
            vc.personalId = tabLeData?.data?[indexPath.row].personalID ?? 0
            vc.officialContact = tabLeData?.data?[indexPath.row].officialMobileNo ?? ""
            vc.personalContact = tabLeData?.data?[indexPath.row].personalContact ?? ""
            vc.officeEmail = tabLeData?.data?[indexPath.row].officialEMailID ?? ""
            vc.personalEmail = tabLeData?.data?[indexPath.row].pernonalEmail ?? ""
            vc.presentAddress = tabLeData?.data?[indexPath.row].presentAddress ?? ""
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
