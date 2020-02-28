//
//  TextFieldWithInsets.swift
//  LiveChat
//
//  Created by Роман Важник on 25/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import Foundation

import UIKit

class TextFieldWithInsets: UITextField {
    
//    private var horisontalInset: CGFloat
//    
//    func setHorisontalInsetForText(inset: CGFloat) {
//        
//    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
}
