//
//  Message.swift
//  LiveChat
//
//  Created by Роман Важник on 20/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import Foundation
import Firebase

struct Message {
    let text: String?
    let imageURL: String?
    let imageWidth: Double?
    let imageHeight: Double?
    let fromId: String
    let toId: String
    let date: Double
    
    init(snapshot: DataSnapshot) {
        let dictionary = snapshot.value as? [String: AnyObject]
        text = dictionary?["text"] as? String
        imageURL = dictionary?["imageURL"] as? String
        imageWidth = dictionary?["imageWidth"] as? Double
        imageHeight = dictionary?["imageHeight"] as? Double
        fromId = dictionary?["fromId"] as! String
        toId = dictionary?["toId"] as! String
        date = dictionary?["date"] as! Double
    }
}
