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
    var applicants: Int
    
    init(post: Post, applicants: Int) {
        self.post = post
        self.applicants = applicants
    }
}

class Post: NSObject, Codable {
    @DocumentID var id: String?
    var userName: String
    var date: String
    var title: String
    var content: String
    var tags: [String]
    var address: String
    
    override init() {
        self.userName = ""
        self.date = ""
        self.title = ""
        self.content = ""
        self.address = ""
        self.tags = []
    }
        
    init(userName: String, date: String, title: String, content: String, tags: [String], address: String) {
        self.userName = userName
        self.date = date
        self.title = title
        self.content = content
        self.tags = tags
        self.address = address
    }
    
    func updateDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        self.date = formatter.string(from: date)
    }
    
    func generateContent() -> String {
        var content = ""
        let tab = "    "
        
        content += "- Degrees: \n"
        /*for degree in EducationViewController.degrees! {
            content += "\(tab)+ \(degree.parseToString())\n"
        }
        
        content += "- Awards: \n"
        for award in EducationViewController.awards! {
            content += "\(tab)+ \(award.parseToString())\n"
        }
        
        content += "- Experience: \n"
        for job in ExperienceViewController.jobs! {
            content += "\(tab)+ \(job.parseToString())\n"
        }
        
        content += "- Skills: \n"
        for skill in SkillsViewController.skills! {
            content += "\(tab)+ \(skill.parseToString())\n"
        }
        
        content += "Phone number: \(BasicsViewController.basicInfo!.phone)"*/
        return content
    }
    
    func createResume() {
        /*let info = BasicsViewController.basicInfo!
        self.date = Utilities.reformatDate(date: info.birth, format: "yyyy/MM/dd")
        self.title = info.name
        self.address = info.address
        
        self.tags = SkillsViewController.tags!
        self.userName = HomepageViewController.username!
        self.content = generateContent()*/
    }
}

