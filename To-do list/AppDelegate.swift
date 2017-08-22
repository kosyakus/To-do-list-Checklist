//
//  AppDelegate.swift
//  To-do list
//
//  Created by Admin on 13.08.17.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

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

