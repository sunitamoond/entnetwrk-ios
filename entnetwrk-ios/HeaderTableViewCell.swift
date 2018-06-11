//
//  HeaderTableViewCell.swift
//  entnetwrk-ios
//
//  Created by Sunita Moond on 11/06/18.
//  Copyright © 2018 Sunita. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!

    func configureHeader(text: String) {
        headerLabel.text = text
    }
}
