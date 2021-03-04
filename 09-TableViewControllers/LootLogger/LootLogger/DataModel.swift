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
        
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        if newItem.valueInDollars > 50 {
            self.ItemStores[0].allItems.append(newItem)
        }else{
            self.ItemStores[1].allItems.append(newItem)
        }

        return newItem
    }
}
