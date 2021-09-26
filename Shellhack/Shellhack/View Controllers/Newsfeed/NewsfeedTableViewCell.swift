//
//  NewsfeedTableViewCell.swift
//  Shellhack
//
//  Created by Don Truong on 9/25/21.
//

import UIKit

class NewsfeedTableViewCell: UITableViewCell {
    @IBOutlet weak var AvatarView: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var ContentLabel: UILabel!
    @IBOutlet weak var WarningLabel: UILabel!
    
    @IBOutlet weak var UpVoteButton: UIButton!
    @IBOutlet weak var DownVoteButton: UIButton!
    
    var id: String?
    var name: String? {
        didSet {
            NameLabel.text = name
        }
    }
    var date: String? {
        didSet {
            DateLabel.text = date
        }
    }
    var affirmation: String? {
        didSet {
            TitleLabel.text = affirmation
        }
    }
    var content: String? {
        didSet {
            ContentLabel.text = content
        }
    }
    var point: Int? {
        didSet {
            guard let point = point else { return }
            if point < 30 {
                WarningLabel.text = "Warning: This post received multiple downvotes!"
                WarningLabel.isHidden = false
                //WarningLabel.textColor = UIColor.systemRed
            } else if point > 85 {
                WarningLabel.text = "This post receive multiple upvotes!"
                WarningLabel.isHidden = false
                //WarningLabel.textColor = UIColor.systemGreen
            } else {
                WarningLabel.isHidden = true
            }
        }
    }
    var post: Post?
    
    @IBAction func voteTapped(_ sender: UIButton) {
        if !validatePermission() {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showError"), object: nil)
            return
        }
        
        UpVoteButton.isHidden = true

        if sender.tag == 0 {
            DownVoteButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
            post!.upVotes += 1
            validateVote(vote: "up")
        } else {
            DownVoteButton.setImage(UIImage(systemName: "hand.thumbsdown.fill"), for: .normal)
            post!.downVotes += 1
            validateVote(vote: "down")
        }
        DownVoteButton.isEnabled = false
        
        Writer.updatePost(postID: id!, post: post!)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateScore"), object: nil)
    }
    
    func validateVote(vote: String) {
        HomepageViewController.totalVotes! += 1
        guard let point = point else { return }
        
        var rightAns = "up"
        if point <= 35 {
            rightAns = "down"
        } else if point < 65 {
            return
        }
                
        if rightAns != vote {
            HomepageViewController.wrongVotes! += 1
        } else {
            HomepageViewController.rightVotes! += 1
        }
    }
    
    func validatePermission() -> Bool {
        let point = HomepageViewController.calculateOverallPoint()
        if point < 20 {
            return false
        }
        
        return true
    }

}

