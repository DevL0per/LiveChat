//
//  ChatScreenNavigationBarView.swift
//  LiveChat
//
//  Created by Роман Важник on 01/03/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

//fileprivate struct Constants {
//    static let profileImageViewWidthAndHeight: CGFloat = 50
//    static let profileImageViewWidthAndHeight: CGFloat = 50
//}

class UserProfileNavigationBarView: UIView {
    
    let profileImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.layer.cornerRadius = 15
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var contentViewWidthAnchor: NSLayoutConstraint!
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupElements(title: String, imageURL: String) {
        nameLabel.text = title
        if imageURL != "" {
            profileImageView.setImage(with: imageURL)
        } else {
            profileImageView.image = UIImage(named: "profileIconForChatScreen")
        }
        contentViewWidthAnchor.isActive = false
        let textWidth = nameLabel.text?.widthWithConstrainedHeight(30, font: UIFont.systemFont(ofSize: 16))
        contentViewWidthAnchor = contentView.widthAnchor.constraint(equalToConstant:
            (textWidth ?? 0) + 35)
        contentViewWidthAnchor.isActive = true
    }
    
    private func layoutElements() {
        addSubview(contentView)
        contentView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        contentViewWidthAnchor = contentView.widthAnchor.constraint(equalToConstant: 0)
        
        contentView.addSubview(profileImageView)
        profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        contentView.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
    }
}
