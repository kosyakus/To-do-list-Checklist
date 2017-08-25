//
//  AppDelegate.swift
//  To-do list
//
//  Created by Admin on 13.08.17.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    
// delegate method that allows the pop ups to be shown even when the app is open
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Received local notification \(notification)")
    }

    var window: UIWindow?
    
    let dataModel = DataModel() // completely different from dataModel object of AllListsVC!!!
    
    func saveData() {
        /*let navigationController = window!.rootViewController as! UINavigationController // the same as let navigationController = window?.rootViewController
        let controller = navigationController.viewControllers[0] as! AllListsViewController
        controller.saveChecklists() */
        
        // simplify
        dataModel.saveChecklists()
    }

// gets called as soon as the app starts up
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = window!.rootViewController as! UINavigationController
        let controller = navigationController.viewControllers[0] as! AllListsViewController
        controller.dataModel = dataModel
        // This finds the AllListsViewController by looking in the storyboard (as before) and then sets its dataModel property
        
        
        let center = UNUserNotificationCenter.current()
        
        // test code
/*        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("We have permission")
            } else {
                print("Permission denied")
            }
        }
        
    // This creates a new local notification
        let content = UNMutableNotificationContent() //describes what the local notification will say
        content.title = "Hello!"
        content.body = "I am a local notification"
        content.sound = UNNotificationSound.default()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
// add the notification to the UNUserNotificationCenter. This object is responsible for keeping track of all the local notifications and making them appear when their time is up
        let request = UNNotificationRequest(identifier: "MyNotification", content: content, trigger: trigger)
        center.add(request)
   */
        center.delegate = self
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        saveData()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveData()
    }


}

