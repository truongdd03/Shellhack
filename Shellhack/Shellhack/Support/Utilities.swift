//
//  Utilities.swift
//  Shellhack
//
//  Created by Don Truong on 9/25/21.
//

import Foundation
import UIKit
import Firebase

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.systemBlue.cgColor
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomLine)
    }
    
    static func styleSimpleTextField(textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.cornerRadius = 5
    }
    
    static func styleTextView(textView: UITextView) {
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemBlue.cgColor
        textView.layer.cornerRadius = 5
    }
    
    static func styleFilledButton(_ button:UIButton) {
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 15.0
        button.tintColor = UIColor.white
    }
    
    static func styleFilledMiniButton(_ button:UIButton, color: UIColor) {
        button.backgroundColor = color
        button.layer.cornerRadius = 10
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        button.backgroundColor = UIColor.white
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 15.0
        button.tintColor = UIColor.black
    }
    
    static func styleHollowMiniButton(_ button:UIButton) {
        button.backgroundColor = UIColor.white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10.0
        button.tintColor = UIColor.black
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func sizeOfLabel(_ str: String) -> CGFloat {
        let label = UILabel()
        label.text = str
            
        return label.intrinsicContentSize.width
    }
 
     static func fetchCountries() -> [String] {
        var countries: [String] = []
        let file = "countries"
        
        if let textFile = Bundle.main.url(forResource: file, withExtension: "txt") {
            if let fileContents = try? String(contentsOf: textFile) {
                countries = fileContents.components(separatedBy: "\n")
            }
        }
        
        return countries
    }
    
    static func reformatDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    static func fetchTags() -> [String] {
        var tags = [String]()
        let file = "tags"
        if let textFile = Bundle.main.url(forResource: file, withExtension: "txt") {
            if let fileContents = try? String(contentsOf: textFile) {
                tags = fileContents.components(separatedBy: "\n")
            }
        }
        tags.removeLast()
        tags.sort()
        return tags
    }
}
