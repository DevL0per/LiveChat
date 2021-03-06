//
//  ChatScreenInteractor.swift
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

protocol ChatsScreenBusinessLogic {
    func doLogout(request: ChatsScreen.Logout.Request)
    func fetchCurrentUser(request: ChatsScreen.FetchCurrentUser.Request)
    func fetchMessages(request: ChatsScreen.FetchMessages.Request)
    func fetchUserToStartChating(request: ChatsScreen.FetchUserToStartChating.Request)
}

protocol ChatsScreenDataStore {
    //var name: String { get set }
}

class ChatsScreenInteractor: ChatsScreenBusinessLogic, ChatsScreenDataStore {
    
    var presenter: ChatsScreenPresentationLogic?
    var worker: ChatsScreenWorker?
    var firebaseManager = FirebaseManager()
    
    func doLogout(request: ChatsScreen.Logout.Request) {
        do {
            try Auth.auth().signOut()
        } catch {
            return
        }
        let response = ChatsScreen.Logout.Response()
        presenter?.userHasLogouted(response: response)
    }
    
    func fetchCurrentUser(request: ChatsScreen.FetchCurrentUser.Request) {
        firebaseManager.fetchCurrentUser { [weak self] (user) in
            guard let user = user else { return }
            self?.presenter?.presentCurrentUser(response: ChatsScreen.FetchCurrentUser.Response(user: user))
        }
    }
    
    func fetchMessages(request: ChatsScreen.FetchMessages.Request) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference(withPath: "userMassages").child(userId)
        ref.observe(.childAdded) { [weak self] (snapshot) in
            let messageFromId = snapshot.key
            let userMessage = ref.child(messageFromId)
            userMessage.observe(.childAdded) { (snapshot) in
                let messageId = snapshot.key
                let messagesRef = Database.database().reference(withPath: "messages").child(messageId)
                messagesRef.observeSingleEvent(of: .value) { (snapshot) in
                    let message = Message(snapshot: snapshot)
                    let userProfileImageRef = Database.database().reference(withPath: "users").child(messageFromId)
                    userProfileImageRef.observeSingleEvent(of: .value) { (snapshot) in
                        let user = User(snapshot: snapshot)
                        let response = ChatsScreen.FetchMessages.Response(message: message,
                                                                          fromUserId: messageFromId,
                                                                          profileImageURL: user.imageURL)
                        self?.presenter?.presentMessages(response: response)
                    }
                }
            }
        }
    }
    
    func fetchUserToStartChating(request: ChatsScreen.FetchUserToStartChating.Request) {
        let ref = Database.database().reference(withPath: "users").child(request.userId)
        ref.observeSingleEvent(of: .value) { [weak self] (snapshot) in
            let user = User(snapshot: snapshot)
            let response = ChatsScreen.FetchUserToStartChating.Response(user: user)
            self?.presenter?.presentUserToStartChating(response: response)
        }
    }
}
