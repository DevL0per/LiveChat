//
//  AlertControllerManager.swift
//  LiveChat
//
//  Created by Роман Важник on 03/03/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

class AlertControllerManager {
    
    static let shared = AlertControllerManager()
    
    func createAlertController(title: String, subtitle: String) -> UIAlertController {
        let alertController = UIAlertController(title: title,
                                                message: subtitle,
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        return alertController
    }
}
