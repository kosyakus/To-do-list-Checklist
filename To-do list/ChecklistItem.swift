//
//  ChecklistItem.swift
//  To-do list
//
//  Created by Admin on 14.08.17.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject { // adding NSObject to satisfy Equitable protocol
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
    
}

