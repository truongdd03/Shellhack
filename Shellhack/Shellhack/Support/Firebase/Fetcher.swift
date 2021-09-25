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
        fetchVotes()
        fetchVoteScore()
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
                        AllPostsViewController.myPosts?.append(post)
                    }
                }
            }
        }
    }
    
    static func filterPostID(keywords: [String], completion: @escaping ([String]) -> Void) {
        let ddb = Database.database().reference().child("Dict")
        var dict = [String: Int]()
        
        let group = DispatchGroup()
        
        for tag in keywords {
            group.enter()
            ddb.child(tag).getData { (err, snapshot) in
                let data = snapshot.value as? [String: Int] ?? [String: Int]()
                for key in data.keys {
                    dict[key] = (dict[key] ?? 0) + data[key]!
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            updatePostID(dict: dict, completion: completion)
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
        
        completion(postsID)
    }
    
    static func fetchVotes() {
        let uid = Auth.auth().currentUser!.uid
        let ref = Database.database().reference().child("Votes").child(uid)
        ref.child("Total").getData(completion: { err, snapshot in
            HomepageViewController.totalVotes = snapshot.value as? Int ?? 0
        })
        ref.child("Right").getData { err, snapshot in
            HomepageViewController.rightVotes = snapshot.value as? Int ?? 0
        }
        ref.child("Wrong").getData { err, snapshot in
            HomepageViewController.wrongVotes = snapshot.value as? Int ?? 0
        }
    }
    
    static func fetchVoteScore() {
        let uid = Auth.auth().currentUser!.uid
        Database.database().reference().child("VoteScore").child(uid).getData { err, snapshot in
            HomepageViewController.votesScores = snapshot.value as? Int ?? 0
        }
    }
}
