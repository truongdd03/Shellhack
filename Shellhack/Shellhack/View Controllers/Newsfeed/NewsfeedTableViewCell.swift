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
                WarningLabel.textColor = UIColor.systemRed
            } else if point > 85 {
                WarningLabel.text = "This post receive multiple upvotes!"
                WarningLabel.isHidden = false
                WarningLabel.textColor = UIColor.systemGreen
            } else {
                WarningLabel.isHidden = true
            }
        }
    }
    var post: Post?
    
    @IBAction func voteTapped(_ sender: UIButton) {
        UpVoteButton.isHidden = true

        if sender.tag == 0 {
            DownVoteButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
            post!.upVotes += 1
        } else {
            DownVoteButton.setImage(UIImage(systemName: "hand.thumbsdown.fill"), for: .normal)
            post!.downVotes += 1
        }
        
        Writer.updatePost(postID: id!, post: post!)
        
    }

}

