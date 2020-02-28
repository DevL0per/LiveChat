//
//  ListOfUsersTableViewCell.swift
//  LiveChat
//
//  Created by Роман Важник on 20/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

class ListOfUsersTableViewCell: UITableViewCell {
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUserElements(with userInfo: ListOfUsers.FetchUsers.ViewModel.UserViewModel) {
        nameLabel.text = userInfo.userName
        bottomLabel.text = userInfo.userEmail
        imageView?.image = UIImage(named: "userImage")
    }
    
    func setupUserMessages(with messageInfo: ChatsScreen.FetchMessages.ViewModel.MessagesViewModel) {
        nameLabel.text = messageInfo.fromUserName
        bottomLabel.text = messageInfo.text
        imageView?.image = UIImage(named: "userImage")
    }
    
    private func setupUI() {
        // photoImageView layout
        addSubview(photoImageView)
        photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 5).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // nameLabel layout
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        
        // emailLabel layout
        addSubview(bottomLabel)
        bottomLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2).isActive = true
        bottomLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 5).isActive = true
        bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
    }
}
