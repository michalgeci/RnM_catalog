//
//  AppDelegate.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 16/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import UIKit

/** Known ISSUES

 https://stackoverflow.com/questions/23882495/cant-endbackgroundtask-no-background-task-exists-with-identifier-or-it-may-ha
 
 https://stackoverflow.com/questions/55372093/uialertcontrollers-actionsheet-gives-constraint-error-on-ios-12-2-12-3
 
 */

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Set primary color for app
        self.window?.tintColor = UIColor.systemGreen
        
        return true
    }

}

