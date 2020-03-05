//
//  ListOfUsersScreenConfigurator.swift
//  LiveChat
//
//  Created by Роман Важник on 05/03/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import Foundation

protocol ListOfUsersScreenConfiguratorProtocol {
    func configure(viewController: ListOfUsersViewController)
}

class ListOfUsersScreenConfigurator: ListOfUsersScreenConfiguratorProtocol {
    func configure(viewController: ListOfUsersViewController) {
        let interactor = ListOfUsersInteractor()
        let presenter = ListOfUsersPresenter()
        let router = ListOfUsersRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
