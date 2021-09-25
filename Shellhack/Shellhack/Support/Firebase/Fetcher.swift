//
//  Fetcher.swift
//  Shellhack
//
//  Created by Don Truong on 9/25/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class Fetcher {
    static let db = Firestore.firestore().collection("Information")
    static var posts = [String: Post]()

    static func fetchAll() {
        fetchUsername()
        fetchMyPosts()
    }
    
    static func fetchUsername() {
        let uid = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("Usernames").document(uid).getDocument { (snapshot, err) in
            let dict = snapshot?.data() as? [String: String] ?? [String: String]()
            HomepageViewController.username = dict["Username"]
        }
    }
    
    static func fetchPost(id: String, completion: @escaping (Post) -> Void) {
        if let post = posts[id] {
            completion(post)
            return
        }
    
        Firestore.firestore().collection("Posts").document(id).getDocument { (snapshot, err) in
            let tmp = try? snapshot?.data(as: Post.self)
            if tmp != nil {
                posts[id] = tmp
                completion(tmp!)
            }
        }
    }
    
    static func fetchPoint(postID: String, completion: @escaping (Int) -> Void) {
        Database.database().reference().child("ApplicantsNumber").child(postID).getData { (err, snapshot) in
            let value = snapshot.value as? Int ?? 0
            completion(value)
        }
    }
    
    static func fetchMyPosts() {
        let uid = Auth.auth().currentUser!.uid
        let ref = Database.database().reference()
        AllPostsViewController.myPosts = []

        ref.child("Posts").child(uid).getData { (err, snapshot) in
            let dict = snapshot.value as? [String: String] ?? [String: String]()
            for key in dict.keys {
                fetchPost(id: key) { (post) in
                    fetchPoint(postID: key) { (value) in
                        AllPostsViewController.myPosts?.append(MyPost(post: post, point: value))
                    }
                }
            }
        }
    }
    
    static func fetchPostID(completion: @escaping ([String]) -> Void) {
        var ids = [String]()
        
        Firestore.firestore().collection("Posts").order(by: "date", descending: true).getDocuments { snapshot, err in
            if let documents = snapshot?.documents {
                for document in documents {
                    ids.append(document.documentID)
                }
            }
            completion(ids)
        }
        
    }
    
    static func updatePostID(dict: [String: Int], completion: @escaping ([String]) -> Void) {
        var postsID = Array(dict.keys)
        postsID.sort() {
            dict[$0]! > dict[$1]!
        }
        
        print(postsID)
        
        // Fetch unrelevant posts
        Firestore.firestore().collection("Posts").getDocuments { (snapshot, err) in
            if let documents = snapshot?.documents {
                for document in documents {
                    let id = document.documentID
                    if dict[id] == nil {
                        postsID.append(id)
                    }
                }
                
                completion(postsID)
            }
        }
    }
}
