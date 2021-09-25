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

class Post: NSObject, Codable {
    @DocumentID var id: String?
    var userName: String
    var date: String
    var affirmation: String
    var content: String
    var upVotes: Int
    var downVotes: Int
    
    override init() {
        self.userName = ""
        self.date = ""
        self.affirmation = ""
        self.content = ""
        self.upVotes = 0
        self.downVotes = 0
    }
        
    init(userName: String, date: String, affirmation: String, content: String) {
        self.userName = userName
        self.date = date
        self.affirmation = affirmation
        self.content = content
        self.upVotes = 0
        self.downVotes = 0
    }
    
    func calculatePoint() -> Int? {
        if self.upVotes + self.downVotes <= 10 {
            return nil
        }
        
        let point = self.upVotes * 100 / (self.upVotes + self.downVotes)
        return Int(point)
    }
    
    func updateDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        self.date = formatter.string(from: date)
    }

}

