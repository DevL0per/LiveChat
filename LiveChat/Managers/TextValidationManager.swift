//
//  TextValidationManager.swift
//  LiveChat
//
//  Created by Роман Важник on 03/03/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import Foundation

enum TextError: Error, CustomStringConvertible {
    case invalidLength(message: String)
    case emptyText(message: String)
    case invalidEmail(message: String)
    case invalidPassword(message: String)
    
    var description: String {
        switch self {
        case .invalidLength(let message):
            return message
        case .emptyText(let message):
            return message
        case .invalidEmail(let message):
            return message
        case .invalidPassword(let message):
            return message
        }
    }
}

class TextValidationManager {
    func validateName(text: String) -> TextError? {
        let textWithoutSpaces = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if textWithoutSpaces.isEmpty {
            return TextError.emptyText(message: "name is empty")
        } else if text.count <= 2 {
            return TextError.invalidLength(message: "name is too small")
        } else if text.count > 10 {
            return TextError.invalidLength(message: "name is too big")
        }
        return nil
    }
    
    func isValidEmail(_ email: String) -> TextError? {
        if email.isEmpty {
            return TextError.emptyText(message: "email is empty")
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if !emailPred.evaluate(with: email) {
            return TextError.invalidEmail(message: "invalid Email")
        }
        return nil
    }
    
    func validatePassword(text: String) -> TextError? {
        if text.isEmpty {
            return TextError.invalidPassword(message: "password is empty")
        } else if text.contains(" ") {
            return TextError.invalidPassword(message: "password can't contain spaces")
        } else if text.count < 6 {
            return TextError.invalidPassword(message: "password must be 6 symbols of more")
        }
        return nil
    }
}
