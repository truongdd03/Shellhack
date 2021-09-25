//
//  Writer.swift
//  Shellhack
//
//  Created by Don Truong on 9/25/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class Writer {
    static let db = Firestore.firestore().collection("Information")
    
    static func writePost(post: Post) -> String? {
        let uid = Auth.auth().currentUser!.uid
        do {
            let id = try Firestore.firestore().collection("Posts").addDocument(from: post).documentID
            Database.database().reference().child("Posts").child(uid).child(id).setValue(id)
            return id
        } catch {
            print("Error")
            return nil
        }
    }
    
    static func writeUsername(username: String) {
        let uid = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("Usernames").document(uid).setData(["Username": username])
    }
    
    static func updatePost(postID: String, post: Post) {
        do {
            try Firestore.firestore().collection("Posts").document(postID).setData(from: post.self)
        } catch {
            print("Error")
        }
    }
}
