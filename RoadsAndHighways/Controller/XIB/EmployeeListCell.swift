//
//  EmployeeListCell.swift
//  RoadsAndHighways
//
//  Created by Muhammad Abdullah Al Mamun on 23/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class EmployeeListCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var degination: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType  = selected ? .checkmark : .none
    }
    
    
    // get photo request
    
    func getEmployeePhoto(personalId: Int) {
        
        guard let getPhotoUrl = URL(string: UrlManager.baseURL() + "rhd/GetPhoto?COMPID=\(personalId)") else { return }
        
        var request = URLRequest(url: getPhotoUrl)
        
        request.setValue("Bearer \(defaults.string(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        request.timeoutInterval = .infinity
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                if let response = response as? HTTPURLResponse, response.isResponseOK() {
                    
                    guard let data = data else {
                        print(String(describing: error))
                        return
                    }
                    
                    if let jsonResponse = try? JSONDecoder().decode(PhotoModel.self, from: data) {
                        
                        if let imageString = jsonResponse.data?.photo {
                            
                            if let imageData = Data(base64Encoded: imageString, options: .ignoreUnknownCharacters) {
                                
                                self.profileImage.image = UIImage(data: imageData)!
                            }
                        }
                    }
                }
            }
        }.resume()
    }
}
