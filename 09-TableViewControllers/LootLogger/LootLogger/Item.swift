// 
//  Copyright © 2020 Big Nerd Ranch
//

import UIKit

class Item: Equatable {
    var name: String
    var valueInDollars: Int?
    var serialNumber: String?
    let dateCreated: Date
    let section: Int
    var isDefault: Bool
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name
            && lhs.serialNumber == rhs.serialNumber
            && lhs.valueInDollars == rhs.valueInDollars
            && lhs.dateCreated == rhs.dateCreated
    }

    init(name: String, serialNumber: String?, valueInDollars: Int?, inSection: Int) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        self.section = inSection
        self.isDefault = false
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            let randomAdjective = adjectives.randomElement()!
            let randomNoun = nouns.randomElement()!

            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int.random(in: 0..<100)
            let randomSerialNumber =
                UUID().uuidString.components(separatedBy: "-").first!
            
        
            if randomValue > 50 {
                self.init(name: randomName,
                          serialNumber: randomSerialNumber,
                          valueInDollars: randomValue,
                          inSection: 0)
            }else{
                self.init(name: randomName,
                          serialNumber: randomSerialNumber,
                          valueInDollars: randomValue,
                          inSection: 1)
            }


        } else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0, inSection: 0)
        }
    }
    
}
