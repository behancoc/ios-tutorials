//
//  ItemStore.swift
//  Homepwner
//
//  Created by Brandon Hancock on 2/1/20.
//  Copyright © 2020 Brandon Hancock. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item(random: true)]
        
    @discardableResult func createItem() -> Item  {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        //Getting the reference of the object being moved
        let movedItem = allItems[fromIndex]
        
        //Remove item from the array
        allItems.remove(at: fromIndex)
        
        //Insert moved item in the array at a new location
        allItems.insert(movedItem, at: toIndex)
    }
}
