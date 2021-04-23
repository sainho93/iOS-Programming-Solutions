//
//  DatePicker.swift
//  LootLogger 3
//
//  Created by sainho on 23.04.21.
//  Copyright © 2021 Big Nerd Ranch. All rights reserved.
//

import UIKit

class DatePickViewController: UIViewController {
    @IBOutlet var dataPicker: UIDatePicker!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    @IBAction func saveDate(_ sender: UIButton) {
        item.dateCreated = dataPicker.date
    }
}
