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
    
}
