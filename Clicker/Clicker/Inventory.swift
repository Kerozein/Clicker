//
//  Inventory.swift
//  Clicker
//
//  Created by Tom Kowal--Picchi on 17/04/2023.
//

import UIKit

class Inventory{
    static let sharedInstance = Inventory()
    var money = 0
    var update = false
    var inventoryItems = [String]()
    var buff = 1.0
    var buffTime = 0
}
