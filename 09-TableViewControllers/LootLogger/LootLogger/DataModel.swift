//
//  DataModel.swift
//  LootLogger
//
//  Created by sainho on 01.03.21.
//  Copyright © 2021 Big Nerd Ranch. All rights reserved.
//

import UIKit

class DataModel {
    var ItemStores: [ItemStore]
    
    init() {
        let moreThan50 = ItemStore(name: "$50 Upper")
        let rest  = ItemStore(name: "Rest")

        self.ItemStores = [moreThan50, rest]
        
        // Add default items
        _ = self.createDefaultItem(inSection: 0)
        _ = self.createDefaultItem(inSection: 1)
        
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        self.ItemStores[newItem.section].allItems.append(newItem)
        
        
        return newItem
    }
    
    @discardableResult func createDefaultItem(inSection section: Int) -> Item {
        let newItem = Item(name: "No items", serialNumber: nil, valueInDollars: nil, inSection: section)
        newItem.isDefault = true
        self.ItemStores[section].allItems.append(newItem)
        
        return newItem
    }

    
    func removeItem(_ item: Item) {
        let section = item.section
        
        if let index = self.ItemStores[section].allItems.firstIndex(of: item) {
            self.ItemStores[section].allItems.remove(at: index)
        }
    }
    
    func moveItem(in section:Int, from fromIndex: Int, to toIndex: Int) {
        
        if fromIndex == toIndex {
            return
        }

        // Get reference to object being moved so you can reinsert it
        let movedItem = self.ItemStores[section].allItems[fromIndex]

        // Remove item from array
        self.ItemStores[section].allItems.remove(at: fromIndex)

        // Insert item in array at new location
        self.ItemStores[section].allItems.insert(movedItem, at: toIndex)
    }

}
