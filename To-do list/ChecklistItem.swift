//
//  ChecklistItem.swift
//  To-do list
//
//  Created by Admin on 14.08.17.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding { // adding NSObject to satisfy Equitable protocol
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
    
// first method to confirm to NSCoding protocol
    // put the objects (save) into the file
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
    }
  
// second method to confirm to NSCoding protocol
    // the method for reading the objects from the file
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        super.init()
    }
    
    override init() {
        super.init()
    }
    
}

