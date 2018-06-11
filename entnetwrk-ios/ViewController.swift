//
//  ViewController.swift
//  entnetwrk-ios
//
//  Created by Sunita Moond on 11/06/18.
//  Copyright © 2018 Sunita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: String(describing: CommentTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CommentTableViewCell.self))
            tableView.register(UINib(nibName: String(describing: PostTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PostTableViewCell.self))
            tableView.register(UINib(nibName: String(describing: HeaderTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing:HeaderTableViewCell.self))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    var comments: [Comment] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Post Detail"
        navigationController?.navigationBar.barTintColor = UIColor.darkText
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count == 0 ? 1 : comments.count + 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderTableViewCell.self), for: indexPath) as! HeaderTableViewCell
            cell.configureHeader(text: comments.count > 1 ? "Comments" : "Comment")

            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CommentTableViewCell.self), for: indexPath) as! CommentTableViewCell
            cell.configureComment(with: comments[indexPath.row - 2])

            return cell
        }
    }
}
