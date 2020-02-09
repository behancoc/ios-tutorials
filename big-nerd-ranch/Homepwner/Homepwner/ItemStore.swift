//
//  ItemStore.swift
//  Homepwner
//
//  Created by Brandon Hancock on 2/1/20.
//  Copyright © 2020 Brandon Hancock. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item()]
        
    @discardableResult func createItem() -> Item  {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
}
