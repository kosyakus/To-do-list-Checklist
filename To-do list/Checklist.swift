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
    
    var iconName: String
    
    /*init(name: String) { //for when you just have a name
        self.name = name
        iconName = "No Icon"
        super.init()
    }*/
    
    convenience init(name: String) {
        self.init(name: name, iconName: "No Icon")
    }
    
    init(name: String, iconName: String) { // for when you also have an icon name (designated init)
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
// methods required by NSCoding protocol:
    // This loads and saves the Checklist’s name and items properties
    required init?(coder aDecoder: NSCoder) { // for loading the objects from the plist file
        name = aDecoder.decodeObject(forKey: "Name") as! String
        items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
        iconName = aDecoder.decodeObject(forKey: "IconName") as! String
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Items")
        aCoder.encode(iconName, forKey: "IconName")
    }
    
    
// func, which count the number of lines in particular checklist (which doesn't have a checkmark)
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items where !item.checked {
            count += 1
        }
        return count
    }
    
}
