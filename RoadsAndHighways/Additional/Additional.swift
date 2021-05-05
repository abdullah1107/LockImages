//
//  Additional.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 13/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

// base URL
class UrlManager: NSObject {
    

    private static let BASE_URL = "http://rhddirapp.rhd.gov.bd:892/api/"
    
    class func baseURL() -> String {
        return BASE_URL
    }
}

// otp
var otp = String()


// half modal viewController

class SetSizePresentationController: UIPresentationController {

    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            return CGRect(x: 0, y: (containerView?.bounds.height ?? 0)/4, width: containerView?.bounds.width ?? 0, height: (containerView?.bounds.height ?? 0)/1)
        }
    }
}



// get photo request
 
extension UIViewController {
    
    func getPhoto(personalId: Int) {
        
        guard let tokenValue = defaults.string(forKey: "token") else { return }
        
        guard let getPhotoUrl = URL(string: UrlManager.baseURL() + "rhd/GetPhoto?COMPID=\(personalId)") else { return }

        var request = URLRequest(url: getPhotoUrl)
        request.setValue("Bearer \(tokenValue)", forHTTPHeaderField: "Authorization")
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
                                
                                profileImage = UIImage(data: imageData)
                            }
                        }
                    }
                }
            }
        }.resume()
    }
}
