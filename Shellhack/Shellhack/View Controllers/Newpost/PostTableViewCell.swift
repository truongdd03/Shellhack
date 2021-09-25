//
//  PostTableViewCell.swift
//  Shellhack
//
//  Created by Don Truong on 9/25/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var PointLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var AffirmationLabel: UILabel!
    @IBOutlet weak var ContentLabel: UILabel!

    var point: Int? {
        didSet {
            PointLabel.text = "0"
        }
    }
    
    var date: String? {
        didSet {
            DateLabel.text = date
        }
    }
    
    var affirmation: String? {
        didSet {
            AffirmationLabel.text = affirmation
        }
    }
    
    var content: String? {
        didSet {
            ContentLabel.text = content
        }
    }

}
