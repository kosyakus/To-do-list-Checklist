//
//  Checklist.swift
//  To-do list
//
//  Created by Admin on 19.08.17.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding { // NSCoding protocol requires to add two methods, init?(coder) and encode(with)

    var name = ""
    var items = [ChecklistItem]() // This creates a new, empty, array that can hold ChecklistItem objects and assigns it to the items instance variable
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
// methods required by NSCoding protocol:
    // This loads and saves the Checklist’s name and items properties
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "Name") as! String
        items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Items")
    }
    
}
