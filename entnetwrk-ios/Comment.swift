//
//  Comment.swift
//  entnetwrk-ios
//
//  Created by Sunita Moond on 11/06/18.
//  Copyright © 2018 Sunita. All rights reserved.
//

import Foundation
import UIKit

struct Comment {
    
    var image: UIImage?
    var text: String?
    var userName: String?
    var userImage: UIImage?

    init(image: UIImage?, text: String?) {
        self.image = image
        self.text = text
    }
}
