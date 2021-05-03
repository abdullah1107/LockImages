//
//  HomeDetailsDB.swift
//  PhotoLocker
//
//  Created by Muhammad Abdullah Al Mamun on 2/5/21.
//

import Foundation
import UIKit

protocol DBHomeDetails {
    func readDBDetails()
    func writeDBDetails()
    func updateDBDetails()
    func deleteDBDetails()
}
