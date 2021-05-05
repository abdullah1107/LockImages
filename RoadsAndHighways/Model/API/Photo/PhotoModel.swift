//
//  PhotoModel.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 15/8/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

struct PhotoModel : Codable {
    
    let data : PhotoData?
    
    enum CodingKeys: String, CodingKey {

        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        data = try values.decodeIfPresent(PhotoData.self, forKey: .data)
    }
}
