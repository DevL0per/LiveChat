//
//  AuthScreenConfigurator.swift
//  LiveChat
//
//  Created by Роман Важник on 18/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import Foundation

protocol AuthorizationScreenConfiguratorProtocol: class {
    func setup(viewController: AuthorizationScreenViewController)
}

class AuthorizationScreenConfigurator: AuthorizationScreenConfiguratorProtocol {
    func setup(viewController: AuthorizationScreenViewController) {
        let interactor = AuthorizationScreenInteractor()
        let presenter = AuthorizationScreenPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}
