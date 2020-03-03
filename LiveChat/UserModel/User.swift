//
//  User.swift
//  LiveChat
//
//  Created by Роман Важник on 19/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import Foundation
import Firebase

struct User {
    let name: String
    let email: String
    let imageURL: String
    let id: String
    
    init(snapshot: DataSnapshot) {
        id = snapshot.key
        let dictionary = snapshot.value as? [String: AnyObject]
        name = dictionary?["name"] as! String
        email = dictionary?["email"] as! String
        imageURL = dictionary?["profileImage"] as! String
    }
}
