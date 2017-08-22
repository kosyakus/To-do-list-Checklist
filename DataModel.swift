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
        registerDefaults()
        handleFirstTime()
    }
    
// this method prevents crashes when first launching the app (and  UserDefaults return 0), now UD returns -1 (main screen)
    func registerDefaults() {
        let dictionary: [String: Any] = [ "ChecklistIndex": -1, "FirstTime": true ]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    var indexOfSelectedChecklist: Int {
        get {
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
        }
    }
    
// check whether it is the first time user open the app. If true, then create some example checklist to show what to do
    func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        if firstTime {
            let checklist = Checklist(name: "List")
            lists.append(checklist)
            indexOfSelectedChecklist = 0 // set indexOfSelectedChecklist to 0, which is the index of this newly added Checklist object, to make sure the app will automatically segue to the new list in AllListsViewController’s viewDidAppear()
            userDefaults.set(false, forKey: "FirstTime")
            userDefaults.synchronize()
        }
    }
    
 
}

