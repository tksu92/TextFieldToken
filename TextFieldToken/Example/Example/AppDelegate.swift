//
//  AppDelegate.swift
//  Example
//
//  Created by sutk on 01/21/2021.
//  Copyright (c) 2021 sutk. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        application.registerForRemoteNotifications()
        return true
    }
}
