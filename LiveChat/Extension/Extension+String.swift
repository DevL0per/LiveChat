//
//  Extension+String.swift
//  LiveChat
//
//  Created by Роман Важник on 24/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

extension String {
    func getTextFrame(font: UIFont) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: self).boundingRect(with: size, options: options,
                                                   attributes: [NSAttributedString.Key.font: font],
                                                   context: nil)
        
    }
}
