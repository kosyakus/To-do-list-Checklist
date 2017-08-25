//
//  ChecklistItem.swift
//  To-do list
//
//  Created by Admin on 14.08.17.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, NSCoding { // adding NSObject to satisfy Equitable protocol
    var text = ""
    var checked = false
    
// items for notification:
    var dueDate = Date()
    var shouldRemind = false
    var itemID: Int
    
    func toggleChecked() {
        checked = !checked
    }
    
// first method to confirm to NSCoding protocol
    // put the objects (save) into the file
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
        
        aCoder.encode(dueDate, forKey: "DueDate")
        aCoder.encode(shouldRemind, forKey: "ShouldRemind")
        aCoder.encode(itemID, forKey: "ItemID")
    }
  
// second method to confirm to NSCoding protocol
    // the method for reading the objects from the file
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        
        dueDate = aDecoder.decodeObject(forKey: "DueDate") as! Date
        shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind")
        itemID = aDecoder.decodeInteger(forKey: "ItemID")
        
        super.init()
    }
    
    override init() {
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
    
// This compares the due date on the item with the current date. The current time can get by making a new Date object with Date()
    // call this method when the user presses the Done button after adding or editing a to-do item
    func scheduleNotification() {
        
        removeNotification()
        
        // when the Remind Me switch is set to “on” and the due date is in the future
        if shouldRemind && dueDate > Date() {
            // Put the item’s text into the notification message
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = text
            content.sound = UNNotificationSound.default()
            // Extract the month, day, hour, and minute from the dueDate
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents(
                [.month, .day, .hour, .minute], from: dueDate)
            // test the local notifications which scheduled the notification to appear after a number of seconds
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components, repeats: false)
            // Create the UNNotificationRequest object. Convert the item’s numeric ID into a String and use it to identify the notification
            let request = UNNotificationRequest(
                identifier: "\(itemID)", content: content, trigger: trigger)
            // Add the new notification to the UNUserNotificationCenter
            let center = UNUserNotificationCenter.current()
            center.add(request)
            print("Scheduled notification \(request) for itemID \(itemID)")
        }
    }
    
// This removes the local notification for this ChecklistItem, if it exists
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(
            withIdentifiers: ["\(itemID)"])
    }
    
    deinit {
        removeNotification()
    }
    
}

