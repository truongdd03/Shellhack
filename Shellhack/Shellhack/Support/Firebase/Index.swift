//
//  Indexer.swift
//  Shellhack
//
//  Created by Don Truong on 9/25/21.
//

import Foundation
import Firebase
import PorterStemmer2

class Index {
    static let db = Database.database().reference().child("Dict")
    static var stopWords: [String]?
    
    static func fetchStopWords() {
        let file = "stopWords"
        if let textFile = Bundle.main.url(forResource: file, withExtension: "txt") {
            if let fileContents = try? String(contentsOf: textFile) {
                stopWords = fileContents.components(separatedBy: "\n")
            }
        }
    }
    
    static func validate(word: String) -> Bool {
        if stopWords == nil {
            fetchStopWords()
        }
    
        if word.count <= 2 || stopWords!.contains(word) { return false }
        for chr in word {
            if !chr.isLetter {
                return false
            }
        }
        return true
    }
    
    static func simplify(words: [String]) -> [String] {
        var res = words
        var id = 0
        while id < res.count {
            if !validate(word: res[id]) {
                res.remove(at: id)
            } else {
                if let stemmer = PorterStemmer(withLanguage: .English) {
                    res[id] = stemmer.stem(res[id])
                }
                id += 1
            }
        }
        return res
    }
    
    static func splitContent(content: String) -> [String] {
        var res = [String]()
        let seperators = CharacterSet(charactersIn: " \n")
        
        res = content.components(separatedBy: seperators)
        for id in 0..<res.count {
            res[id] = res[id].lowercased()

            if res[id].count > 0 && !res[id].first!.isLetter {
                res[id].removeFirst()
            }
            if res[id].count > 0 && !res[id].last!.isLetter {
                res[id].removeLast()
            }
        }
        
        res = simplify(words: res)
        res.sort()
        
        return res
    }
    
    static func addWord(word: String, times: Int, postID: String) {
        db.child(word).child(postID).setValue(times)
    }
    
    static func removeWord(word: String, postID: String) {
        db.child(word).child(postID).removeValue()
    }
    
    static func updatePost(content: String, postID: String, isDelete: Bool) {
        var words = splitContent(content: content)
        words.append("~_~")
        var times = 1
        
        for id in 1..<words.count {
            if words[id] != words[id-1] {
                if !isDelete {
                    addWord(word: words[id-1], times: times, postID: postID)
                } else {
                    removeWord(word: words[id-1], postID: postID)
                }
                times = 1
            } else {
                times += 1
            }
        }
    }

}
