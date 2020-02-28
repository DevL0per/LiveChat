//
//  ChatScreenWithUserCollectionViewCell.swift
//  LiveChat
//
//  Created by Роман Важник on 22/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

protocol ChatScreenWithUserCollectionViewCellDelegate {
    func performMessageImageZoomIn(imageView: UIImageView)
}

class ChatScreenWithUserCollectionViewCell: UICollectionViewCell {
    
    var delegate: ChatScreenWithUserCollectionViewCellDelegate!
    
    var textMessage: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.padding = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 0)
        label.font = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = #colorLiteral(red: 0.9317067266, green: 0.3866539598, blue: 0.6329562068, alpha: 1)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var messageImage: CachedImageView = {
        let imageView = CachedImageView()
        imageView.isHidden = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(performMessageImageZoomIn)))
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var textMessageTimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 11)
        label.backgroundColor = #colorLiteral(red: 0.9317067266, green: 0.3866539598, blue: 0.6329562068, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var messageContentView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9317067266, green: 0.3866539598, blue: 0.6329562068, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var textWidthConstant = 0
    var textMessageRightConstraint: NSLayoutConstraint!
    var textMessageLeftConstraint: NSLayoutConstraint!
    var textMessageWidth: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutFirstLayer()
        layoutSecondLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextMessageWidth(with constant: CGFloat) {
        textMessageWidth?.isActive = false
        textMessageWidth = messageContentView.widthAnchor.constraint(equalToConstant: constant+30)
        textMessageWidth?.isActive = true
    }
    
    func setupElements(with message: ChatScreen.FetchMessage.ViewModel.MessageViewModel) {
        textMessage.text = message.textMessage
        textMessageTimeLabel.text = message.time
        textMessageLeftConstraint.isActive = false
        textMessageRightConstraint.isActive = false
        if message.isMessageFromUser {
            textMessageLeftConstraint.isActive = true
        } else {
            textMessage.backgroundColor = #colorLiteral(red: 0.1333177388, green: 0.1333433092, blue: 0.1333121657, alpha: 1)
            messageContentView.backgroundColor = #colorLiteral(red: 0.1333177388, green: 0.1333433092, blue: 0.1333121657, alpha: 1)
            textMessageTimeLabel.backgroundColor = #colorLiteral(red: 0.1333177388, green: 0.1333433092, blue: 0.1333121657, alpha: 1)
            textMessageRightConstraint.isActive = true
        }
        if message.imageURL != nil {
            messageImage.setImage(with: message.imageURL)
            textMessage.isHidden = true
            messageImage.isHidden = false
        }
    }
    
    @objc private func performMessageImageZoomIn() {
        delegate.performMessageImageZoomIn(imageView: messageImage)
    }
    
    @objc private func performMessageImageZoomOut() {
        
    }
    
    private func layoutSecondLayer() {
        addSubview(textMessageTimeLabel)
        addSubview(textMessage)
        addSubview(messageImage)
        textMessageTimeLabel.leadingAnchor.constraint(equalTo: textMessage.trailingAnchor, constant: 3).isActive = true
        textMessageTimeLabel.trailingAnchor.constraint(equalTo: messageContentView.trailingAnchor, constant: -2).isActive = true
        textMessageTimeLabel.bottomAnchor.constraint(equalTo: messageContentView.bottomAnchor, constant: -2).isActive = true
        textMessageTimeLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        textMessage.leadingAnchor.constraint(equalTo: messageContentView.leadingAnchor).isActive = true
        textMessage.topAnchor.constraint(equalTo: messageContentView.topAnchor).isActive = true
        textMessage.bottomAnchor.constraint(equalTo: messageContentView.bottomAnchor).isActive = true
        
        messageImage.leadingAnchor.constraint(equalTo: messageContentView.leadingAnchor).isActive = true
        messageImage.trailingAnchor.constraint(equalTo: textMessageTimeLabel.leadingAnchor, constant: -2).isActive = true
        messageImage.topAnchor.constraint(equalTo: messageContentView.topAnchor).isActive = true
        messageImage.bottomAnchor.constraint(equalTo: messageContentView.bottomAnchor).isActive = true
    }
    
    private func layoutFirstLayer() {
        addSubview(messageContentView)
        textMessageLeftConstraint = messageContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5)
        textMessageRightConstraint = messageContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        textMessageWidth = messageContentView.widthAnchor.constraint(equalToConstant: 0)
        messageContentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        messageContentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
