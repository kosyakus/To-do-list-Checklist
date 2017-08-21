//
//  Checklist.swift
//  To-do list
//
//  Created by Admin on 19.08.17.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit

class Checklist: NSObject {

    var name = ""
    var items = [ChecklistItem]() // This creates a new, empty, array that can hold ChecklistItem objects and assigns it to the items instance variable
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
}
