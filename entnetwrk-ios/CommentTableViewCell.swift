//
//  CommentTableViewCell.swift
//  entnetwrk-ios
//
//  Created by Sunita Moond on 11/06/18.
//  Copyright © 2018 Sunita. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel! {
        didSet {
            userNameLabel.text = "Sunita Moond"
        }
    }
    @IBOutlet weak var userImageVIew: UIImageView! {
        didSet {
            userImageVIew.layer.cornerRadius = userImageVIew.bounds.width/2
            userImageVIew.layer.masksToBounds = true
            userImageVIew.contentMode = .scaleAspectFill
            userImageVIew.image = #imageLiteral(resourceName: "user")
        }
    }
    @IBOutlet weak var commentTextLabel: UILabel!

    func configureComment(with comment: Comment) {
        commentTextLabel.text = comment.text
    }
}
