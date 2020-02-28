//
//  ImageSizeManager.swift
//  LiveChat
//
//  Created by Роман Важник on 27/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

fileprivate struct Constans {
    static let imageWidth = UIScreen.main.bounds.width/2
}

class ImageSizeManager {
    
    static let shared = ImageSizeManager()
    
    func getImageSize(width: Double, height: Double) -> CGRect {
        let ratio = width/height
        let newHeight = Constans.imageWidth/CGFloat(ratio)
        return CGRect(x: 0, y: 0, width: Constans.imageWidth, height: newHeight)
    }
}
