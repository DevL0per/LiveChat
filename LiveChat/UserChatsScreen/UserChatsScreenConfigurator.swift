//
//  UserChatsScreenConfigurator.swift
//  LiveChat
//
//  Created by Роман Важник on 03/03/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import Foundation

protocol UserChatsScreenConfiguratorProtocol {
    func configure(viewController: ChatsScreenViewController)
}

class UserChatsScreenConfigurator: UserChatsScreenConfiguratorProtocol {
    
    func configure(viewController: ChatsScreenViewController) {
        let interactor = ChatsScreenInteractor()
        let presenter = ChatsScreenPresenter()
        let router = ChatsScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
