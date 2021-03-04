// 
//  Copyright © 2020 Big Nerd Ranch
//

import UIKit

class ItemStore {

    var allItems: [Item]
    let name: String
    
    init(name: String) {
        self.allItems = [Item]()
        self.name = name
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

        // Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]

        // Remove item from array
        allItems.remove(at: fromIndex)

        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
}
