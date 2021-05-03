
//  OptionVC.swift
//  PhotoLocker
//  Created by Muhammad Abdullah Al Mamun on 23/4/21.


import UIKit

class OptionVC: UIViewController {
    
    var optionIndex:Int = Int()
    var primaryKey:String = String()
    
    @IBOutlet weak var optionTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(optionIndex,primaryKey)
        optionTableView.dataSource = self
        optionTableView.delegate = self
        self.optionTableView.tableFooterView = UIView()
        self.optionTableView.estimatedRowHeight = 80

        // Do any additional setup after loading the view.
    }
    


}

extension OptionVC:UITableViewDataSource,UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Album Settings"
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40.0
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OptionCell
        
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Name"
            cell.detailsLabel.text = "Photo Album"
            
            
            cell.accessoryType = .disclosureIndicator
            cell.imageview.isHidden = true
            
            break
        case 1:
            cell.textLabel?.text = "Cover Photo"
            cell.detailsLabel.isHidden = true
            cell.accessoryType = .disclosureIndicator
            cell.imageview.image = UIImage(named: "image")
            break
        case 2:
            cell.textLabel?.text = "Album Lock"
            cell.detailsLabel.text = "Unlock"
            cell.accessoryType = .disclosureIndicator
            cell.imageview.isHidden = true
            break
        case 3:
            cell.textLabel?.text = "Delete"
            cell.detailsLabel.text = "To delete Album"
            cell.accessoryType = .disclosureIndicator
            cell.imageview.isHidden = true
            break
            
        default: break
            
        }
        
       
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("Index:", indexPath.row)
    }
    
    
}
