//
//  MainTabBar.swift
//  LiveChat
//
//  Created by Роман Важник on 29/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {
    
    override func viewDidLoad() {
        viewControllers = [createMainScreen(), createSettingsScreen()]
        tabBar.barTintColor = #colorLiteral(red: 0.1333177388, green: 0.1333433092, blue: 0.1333121657, alpha: 1)
        tabBar.tintColor = .white
    }
    
    private func createMainScreen() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: AuthorizationScreenViewController())
        navigationController.tabBarItem.image = UIImage(named: "chatTabBarIcon")
        navigationController.tabBarItem.title = "Chat"
        return navigationController
    }
    
    private func createSettingsScreen() -> SettingsScreenViewController {
        let settingsVC = SettingsScreenViewController()
        settingsVC.tabBarItem.title = "Settings"
        settingsVC.tabBarItem.image = UIImage(named: "settingsIcon")
        return settingsVC
    }
}
