//
//  DataModel.swift
//  To-do list
//
//  Created by Admin on 22.08.17.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation

// DataModel will be taking over the responsibilities for loading and saving the to-do lists from AllListsViewController

class DataModel {
    var lists = [Checklist]()
    
// the load/save code
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
 
 
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
 
 
// this method is now called saveChecklists()
    func saveChecklists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(lists, forKey: "Checklists")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
 
 
// this method is now called loadChecklists()
    func loadChecklists() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            lists = unarchiver.decodeObject(forKey: "Checklists") as! [Checklist]
            unarchiver.finishDecoding()
        }
    }

// as soon as the DataModel object is created, it will attempt to load Checklists.plist
    init() {
        loadChecklists()
    }
    
 
}

