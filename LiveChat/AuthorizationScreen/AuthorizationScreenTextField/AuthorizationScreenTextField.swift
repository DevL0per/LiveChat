//
//  AuthorizationScreenTextField.swift
//  LiveChat
//
//  Created by Роман Важник on 24/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

class AuthorizationScreenTextField: TextFieldWithInsets {
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        layer.cornerRadius = 15
        textColor = .white
        autocorrectionType = .no
        backgroundColor = #colorLiteral(red: 0.2156862745, green: 0.1921568627, blue: 0.2941176471, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPlaceHolderWithWhiteColor(text: String) {
        attributedPlaceholder = NSAttributedString(string: text,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}
