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

protocol ChatScreenPresentationLogic {
    func userHasLogouted(response: ChatScreen.Logout.Response)
    func presentUserName(response: ChatScreen.FetchUserName.Response)
}

class ChatScreenPresenter: ChatScreenPresentationLogic {
    
    weak var viewController: ChatScreenDisplayLogic?
    
    func userHasLogouted(response: ChatScreen.Logout.Response) {
        let viewModel = ChatScreen.Logout.ViewModel()
        viewController?.displayLoginScreen(viewModel: viewModel)
    }
    
    func presentUserName(response: ChatScreen.FetchUserName.Response) {
        let name = response.user.name
        let viewModel = ChatScreen.FetchUserName.ViewModel(userName: name)
        viewController?.displayUserName(viewModel: viewModel)
    }
}