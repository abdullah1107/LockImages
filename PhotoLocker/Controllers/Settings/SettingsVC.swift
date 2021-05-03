//  SettingsVC.swift
//  PhotoLocker
//  Created by Muhammad Abdullah Al Mamun on 24/4/21.


import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var settingtopIcon: UIImageView!
    
    @IBOutlet weak var settingsTV: UITableView!
    
    let cellSpacingHeight: CGFloat = 10
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        settingsTV.dataSource = self
        settingsTV.delegate = self
        self.settingsTV.tableFooterView = UIView()
        self.settingsTV.estimatedRowHeight = 80

    }
    

 

}

extension SettingsVC:UITableViewDataSource, UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    // MARK: - Height For Header In Section
    
    
//    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsTVCell
        
        cell.textLabel?.text = "Settings"
        cell.imageView?.image = UIImage(named: "settings")
        cell.detailTextLabel?.text = "details"
        cell.accessoryType = .disclosureIndicator
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("indexPath", indexPath.section)
    }
    
    
}
