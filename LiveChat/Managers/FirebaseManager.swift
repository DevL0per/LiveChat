//
//  FirebaseManager.swift
//  LiveChat
//
//  Created by Роман Важник on 29/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import Firebase

class FirebaseManager {
    
    func saveImageInStorage(withPath path: String, image: UIImage, closer: @escaping (URL?, Error?)->()) {
        guard let jpegData = image.jpegData(compressionQuality: 0.2) else { return }
        let imageId = NSUUID().uuidString
        let ref = Storage.storage().reference().child(path).child(imageId)
        ref.putData(jpegData, metadata: nil) { (metadata, error) in
            if let error = error {
                print(error)
                return
            }
            ref.downloadURL { (url, error) in
                guard let url = url else { return }
                closer(url, error)
            }
        }
    }
    
    func fetchCurrentUser(closer: @escaping (User?)->()) {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            closer(nil)
            return
        }
        let ref = Database.database().reference(withPath: "users").child(currentUserId)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            let user = User(snapshot: snapshot)
            closer(user)
        }
    }
    
}
