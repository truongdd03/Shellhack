//
//  Post.swift
//  Shellhack
//
//  Created by Don Truong on 9/25/21.
//

import UIKit

import UIKit
import FirebaseFirestoreSwift
import Firebase

class MyPost: NSObject {
    var post: Post
    var point: Int
    
    init(post: Post, point: Int) {
        self.post = post
        self.point = point
    }
}

class Post: NSObject, Codable {
    @DocumentID var id: String?
    var userName: String
    var date: String
    var affirmation: String
    var content: String
    
    override init() {
        self.userName = ""
        self.date = ""
        self.affirmation = ""
        self.content = ""
    }
        
    init(userName: String, date: String, affirmation: String, content: String) {
        self.userName = userName
        self.date = date
        self.affirmation = affirmation
        self.content = content
    }
    
    func updateDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        self.date = formatter.string(from: date)
    }

}

