//
//  ChatScreenPresenter.swift
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

protocol ChatsScreenPresentationLogic {
    func userHasLogouted(response: ChatsScreen.Logout.Response)
    func presentCurrentUser(response: ChatsScreen.FetchCurrentUser.Response)
    func presentMessages(response: ChatsScreen.FetchMessages.Response)
    func presentUserToStartChating(response: ChatsScreen.FetchUserToStartChating.Response)
}

class ChatsScreenPresenter: ChatsScreenPresentationLogic {
    
    weak var viewController: ChatsScreenDisplayLogic?
    var dateFormatter = MyDateFormatter()
    
    func userHasLogouted(response: ChatsScreen.Logout.Response) {
        let viewModel = ChatsScreen.Logout.ViewModel()
        viewController?.displayLoginScreen(viewModel: viewModel)
    }
    
    func presentCurrentUser(response: ChatsScreen.FetchCurrentUser.Response) {
        let userViewModel = ListOfUsers.FetchUsers.ViewModel.UserViewModel(userName: response.user.name,
                                                                           userEmail: response.user.email,
                                                                           userImageURL: response.user.imageURL,
                                                                           userId: response.user.id)
        let viewModel = ChatsScreen.FetchCurrentUser.ViewModel(userViewModel: userViewModel)
        viewController?.displayCurrentUser(viewModel: viewModel)
    }
    
    func presentMessages(response: ChatsScreen.FetchMessages.Response) {
        fetchUserName(from: response.fromUserId) { [weak self] fromUserName in
            let date = self?.dateFormatter.formatToString(from: response.message.date)
            let messageViewModel = ChatsScreen.FetchMessages.ViewModel.MessagesViewModel(text: response.message.text ?? "image",
                                                                                         fromUserName: fromUserName,
                                                                                         profileImageURL: response.profileImageURL,
                                                                                         fromUserId: response.fromUserId,
                                                                                         stringDate: date ?? "",
                                                                                         dateToCompare: response.message.date)
            let viewModel = ChatsScreen.FetchMessages.ViewModel(key: response.fromUserId, value: messageViewModel)
            self?.viewController?.displayMessages(viewModel: viewModel)
        }
    }
    
    private func fetchUserName(from userId: String, completion: @escaping (String) -> ()) {
        let ref = Database.database().reference(withPath: "users").child(userId)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            let user = User(snapshot: snapshot)
            completion(user.name)
        }
    }
    
    func presentUserToStartChating(response: ChatsScreen.FetchUserToStartChating.Response) {
        let userViewModel = ListOfUsers.FetchUsers.ViewModel.UserViewModel(userName: response.user.name,
                                                                           userEmail: response.user.email,
                                                                           userImageURL: response.user.imageURL,
                                                                           userId: response.user.id)
        let viewModel = ChatsScreen.FetchUserToStartChating.ViewModel(userViewModel: userViewModel)
        viewController?.startChatWithUser(viewModel: viewModel)
    }
}
