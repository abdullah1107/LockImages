//
//  TVHomeDetails.swift
//  PhotoLocker
//
//  Created by Muhammad Abdullah Al Mamun on 26/4/21.
//

import Foundation
import UIKit

extension HomeDetailsVC: UITableViewDataSource, UITableViewDelegate,CellDelegateTV{
    
    func optionButtonTV(index: Int) {
        debugPrint("Index:", index)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listTV.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailsTVCell
        
        cell.cellDelegate = self
        cell.optionButton.tag = indexPath.row
        
        return self.setDetailsTVCell(cell: cell)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
