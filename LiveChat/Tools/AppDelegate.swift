//
//  AppDelegate.swift
//  LiveChat
//
//  Created by Роман Важник on 17/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
    
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = MainTabBar()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }

}

