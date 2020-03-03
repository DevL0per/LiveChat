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
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let photoImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.layer.cornerRadius = 25
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 0.1333177388, green: 0.1333433092, blue: 0.1333121657, alpha: 1)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUserElements(with userInfo: ListOfUsers.FetchUsers.ViewModel.UserViewModel) {
        
        photoImageView.image = nil
        
        nameLabel.text = userInfo.userName
        bottomLabel.text = userInfo.userEmail
        
        if userInfo.userImageURL != "" {
            photoImageView.setImage(with: userInfo.userImageURL)
            photoImageView.contentMode = .center
        } else {
            photoImageView.image = UIImage(named: "profileImage")
            photoImageView.contentMode = .scaleAspectFit
        }
    }
    
    func setupUserMessages(with messageInfo: ChatsScreen.FetchMessages.ViewModel.MessagesViewModel) {
        nameLabel.text = messageInfo.fromUserName
        bottomLabel.text = messageInfo.text
        
        if messageInfo.profileImageURL != "" {
            photoImageView.setImage(with: messageInfo.profileImageURL)
        } else {
            photoImageView.image = UIImage(named: "profileImage")
        }
    }
    
    private func setupUI() {
        // photoImageView layout
        addSubview(photoImageView)
        photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
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
        bottomLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 6).isActive = true
        bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
    }
}
