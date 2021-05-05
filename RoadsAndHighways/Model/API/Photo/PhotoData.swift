//
//  PhotoData.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 15/8/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

struct PhotoData : Codable {
    
    let photo : String?
    
    enum CodingKeys: String, CodingKey {

        case photo = "Photo"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        photo = try values.decodeIfPresent(String.self, forKey: .photo)
    }
}
