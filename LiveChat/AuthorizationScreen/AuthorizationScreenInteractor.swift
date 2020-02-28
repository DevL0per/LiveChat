//
//  AuthorizationScreenInteractor.swift
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
import Firebase

protocol AuthorizationScreenBusinessLogic {
    func saveUser(request: AuthorizationScreen.SaveUser.Request)
    func login(request: AuthorizationScreen.Login.Request)
    func changeTextFieldHeight(request: AuthorizationScreen.ChangeTextFieldHeight.Request)
    func checkIfUserAvailable(requset: AuthorizationScreen.CheckIfUserAvailable.Request)
}

protocol AuthorizationScreenDataStore {
    //var name: String { get set }
}

class AuthorizationScreenInteractor: AuthorizationScreenBusinessLogic, AuthorizationScreenDataStore {
    
    var presenter: AuthorizationScreenPresentationLogic?
    var worker: AuthorizationScreenWorker?
    
    private let url = "https://livechat-902e9.firebaseio.com/"
    //private let storage = Storage.storage(url: url)
  
    // MARK: Do something
    
    func saveUser(request: AuthorizationScreen.SaveUser.Request) {
        guard let email = request.userEmail,
              let name = request.userName,
              let password = request.userPassword else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { [unowned self] (result, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let userId = result?.user.uid else { return }
            
            let values = ["name": name, "email": email]
            var ref = Database.database().reference(fromURL: self.url)
            ref  = ref.child("users").child(userId)
            ref.updateChildValues(values) { (error, ref) in
                if let error = error {
                    print(error)
                    return
                }
            }
            self.presenter?.presentUser()
        }
    }   
    
    func checkIfUserAvailable(requset: AuthorizationScreen.CheckIfUserAvailable.Request) {
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if user != nil {
                self?.presenter?.presentUser()
            }
        }
    }
    
    func login(request: AuthorizationScreen.Login.Request) {
        guard let email = request.userEmail, let password = request.userPassword
        else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print(error)
                return
            }
        }
    }
    
    func changeTextFieldHeight(request: AuthorizationScreen.ChangeTextFieldHeight.Request) {
        let segmentedTitle = request.segmentedTitle
        var newsHeightForTextField: CGFloat
        switch segmentedTitle {
        case "login":
            newsHeightForTextField = 0
        case "registration":
            newsHeightForTextField = 45
        default:
            return
        }
        let response = AuthorizationScreen.ChangeTextFieldHeight.Response(heightConstant: newsHeightForTextField)
        presenter?.presentNewTextFieldHeight(response: response)
    }
    
}
