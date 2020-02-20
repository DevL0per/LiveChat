//
//  AuthorizationScreenRouter.swift
//  LiveChat
//
//  Created by Роман Важник on 18/02/2020.
//  Copyright (c) 2020 Роман Важник. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol AuthorizationScreenRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol AuthorizationScreenDataPassing {
    var dataStore: AuthorizationScreenDataStore? { get }
}

class AuthorizationScreenRouter: NSObject, AuthorizationScreenRoutingLogic, AuthorizationScreenDataPassing {
    
    weak var viewController: AuthorizationScreenViewController?
    var dataStore: AuthorizationScreenDataStore?
    
    // MARK: Navigation
    
//    func navigateToChatScreen(source: AuthorizationScreenViewController, destination: ChatScreenViewController) {
//        source.presentViewController(destination, animated: true, completion: nil)
//    }
//
    // MARK: Passing data
    
    //func passDataToSomewhere(source: AuthorizationScreenDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
