//
//  ChatScreenViewController.swift
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

fileprivate struct Constants {
    static let tableViewCellHeight: CGFloat = 60
}

protocol ChatsScreenDisplayLogic: class {
    func displayLoginScreen(viewModel: ChatsScreen.Logout.ViewModel)
    func displayCurrentUser(viewModel: ChatsScreen.FetchCurrentUser.ViewModel)
    func displayMessages(viewModel: ChatsScreen.FetchMessages.ViewModel)
    func startChatWithUser(viewModel: ChatsScreen.FetchUserToStartChating.ViewModel)
}

class ChatsScreenViewController: UIViewController, ChatsScreenDisplayLogic {
    
    // MARK: - Properties
    var interactor: ChatsScreenBusinessLogic?
    var configurator: UserChatsScreenConfiguratorProtocol = UserChatsScreenConfigurator()
    
    var router: (NSObjectProtocol & ChatsScreenRoutingLogic & ChatsScreenDataPassing)?
    var messagesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let selectedBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var isCurrentUserExist: Bool = true
    private let userProfileNavigationBarView = UserProfileNavigationBarView()
    
    private var messagesDictionarys: [String: ChatsScreen.FetchMessages.ViewModel.MessagesViewModel] = [:]
    private var messagesViewModel: [ChatsScreen.FetchMessages.ViewModel.MessagesViewModel]?
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(viewController: self)
        setupNavigationController()
        setupNavigationItemLeftButton()
        setupNavigationItemRightButton()
        setupMessagesTableView()
        interactor?.fetchMessages(request: ChatsScreen.FetchMessages.Request())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchCurrentUser(request: ChatsScreen.FetchCurrentUser.Request())
        navigationController?.setNavigationBarHidden(false, animated: false)
        tabBarController?.tabBar.isHidden = false
    }
    
    deinit {
        if isCurrentUserExist {
            interactor?.doLogout(request: ChatsScreen.Logout.Request())
        }
    }
    
    func startChatWithUser(viewModel: ChatsScreen.FetchUserToStartChating.ViewModel) {
        let vc = ChatScreenViewController()
        vc.user = viewModel.userViewModel
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func displayMessages(viewModel: ChatsScreen.FetchMessages.ViewModel) {
        messagesDictionarys[viewModel.key] = viewModel.value
        messagesViewModel = Array(messagesDictionarys.values)
        messagesViewModel?.sort { $0.dateToCompare > $1.dateToCompare }
        messagesTableView.reloadData()
    }
    
    func displayCurrentUser(viewModel: ChatsScreen.FetchCurrentUser.ViewModel) {
        userProfileNavigationBarView.setupElements(title: viewModel.userViewModel.userName,
                                                   imageURL: viewModel.userViewModel.userImageURL)
    }
    
    func displayLoginScreen(viewModel: ChatsScreen.Logout.ViewModel) {
        self.navigationController?.popViewController(animated: true)
        isCurrentUserExist = false
    }
    
    private func setupNavigationItemLeftButton() {
        let button = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(doLogout))
        navigationItem.leftBarButtonItem = button
    }
    
    @objc private func doLogout() {
        interactor?.doLogout(request: ChatsScreen.Logout.Request())
    }
    
    private func setupNavigationItemRightButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showAllUsers))
        navigationItem.rightBarButtonItem = button
    }

    @objc private func showAllUsers() {
        let vc = ListOfUsersViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupMessagesTableView() {
        view.addSubview(messagesTableView)
        messagesTableView.tableFooterView = UIView()
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        messagesTableView.backgroundColor = .black
        messagesTableView.register(ListOfUsersTableViewCell.self, forCellReuseIdentifier: "messagesCell")
        
        messagesTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        messagesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        messagesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        messagesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    private func setupNavigationController() {
        navigationItem.titleView = userProfileNavigationBarView
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ChatsScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesViewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messagesCell") as! ListOfUsersTableViewCell
        cell.selectedBackgroundView = selectedBackgroundView
        guard let messageViewModel = messagesViewModel?[indexPath.row] else { return UITableViewCell() }
        cell.setupUserMessages(with: messageViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let userId = messagesViewModel?[indexPath.row].fromUserId else { return }
        let request = ChatsScreen.FetchUserToStartChating.Request(userId: userId)
        interactor?.fetchUserToStartChating(request: request)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableViewCellHeight
    }
}
