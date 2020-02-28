//
//  ChatScreenPresenter.swift
//  LiveChat
//
//  Created by Роман Важник on 20/02/2020.
//  Copyright (c) 2020 Роман Важник. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ChatScreenPresentationLogic {
    func presentMessage(response: ChatScreen.SendMessage.Response)
    func presentMessage(response: ChatScreen.FetchMessage.Response)
}

class ChatScreenPresenter: ChatScreenPresentationLogic {
    
    weak var viewController: ChatScreenDisplayLogic?
    var dateFormatter = MyDateFormatter()
    
    func presentMessage(response: ChatScreen.SendMessage.Response) {
        let viewModel = ChatScreen.SendMessage.ViewModel()
        viewController?.messageWasSended(viewModel: viewModel)
    }
    
    func presentMessage(response: ChatScreen.FetchMessage.Response) {
        let flag = isMessageFromUser(message: response.message,
                                                  fromUserID: response.fromUserId)
        let date = dateFormatter.formatToString(from: response.message.date)
        var messageSize: CGRect!
        if let text = response.message.text {
            messageSize = getMessageSize(text: text)
        } else if let imageWidth = response.message.imageWidth, let imageHeight = response.message.imageHeight {
            messageSize = ImageSizeManager.shared.getImageSize(width: imageWidth, height: imageHeight)
        }
        let viewModel = ChatScreen.FetchMessage.ViewModel.MessageViewModel(textMessage: response.message.text,
                                                                           imageURL: response.message.imageURL,
                                                                           imageWidth: response.message.imageWidth,
                                                                           imageHeight: response.message.imageHeight,
                                                                           isMessageFromUser: flag,
                                                                           time: date,
                                                                           messageSize: messageSize)
        viewController?.displayMessage(viewModel: ChatScreen.FetchMessage.ViewModel(messageViewModel: viewModel))
    }
    
    private func getMessageSize(text: String) -> CGRect {
        return text.getTextFrame(font: UIFont.systemFont(ofSize: 16))
    }
    
    private func isMessageFromUser(message: Message, fromUserID: String) -> Bool {
        return message.fromId == fromUserID ? true : false
    }
}