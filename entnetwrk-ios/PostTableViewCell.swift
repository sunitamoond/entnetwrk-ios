//
//  PostTableViewCell.swift
//  entnetwrk-ios
//
//  Created by Sunita Moond on 11/06/18.
//  Copyright © 2018 Sunita. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            userImageView.layer.cornerRadius = userImageView.bounds.width/2
            userImageView.layer.masksToBounds = true
            userImageView.contentMode = .scaleAspectFill
            userImageView.image = #imageLiteral(resourceName: "user")
        }
    }
    @IBOutlet weak var userNameLabel: UILabel! {
        didSet {
            userNameLabel.text = "Sunita Moond"
        }
    }
    @IBOutlet weak var contentLabel: UILabel! {
        didSet {
            contentLabel.text = "You can use AJAX to call the Random User Generator API and will receive a randomly generated user in return. If you are using jQuery, you can use the $.ajax() function in the code snippet below to get started."
        }
    }
    @IBOutlet weak var postImageView: UIImageView! {
        didSet {
            postImageView.image = #imageLiteral(resourceName: "random_image")
        }
    }

    func configure() {

    }
}
