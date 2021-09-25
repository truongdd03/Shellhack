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
    var title: String? {
        didSet {
            TitleLabel.text = title
        }
    }
    var content: String? {
        didSet {
            ContentLabel.text = content
        }
    }
    var postID: String?

}

