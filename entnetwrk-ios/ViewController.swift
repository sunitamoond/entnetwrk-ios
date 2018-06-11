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
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            userImageView.layer.cornerRadius = userImageView.bounds.width/2
            userImageView.layer.masksToBounds = true
            userImageView.contentMode = .scaleAspectFill
            userImageView.image = #imageLiteral(resourceName: "user")
        }
    }
    @IBOutlet weak var commentTextView: UITextView! {
        didSet  {
            commentTextView.isScrollEnabled = false
            commentTextView.text = ""
            commentTextView.textColor = .black
            commentTextView.delegate = self
        }
    }
    @IBOutlet weak var placeholderLabel: UILabel! {
        didSet {
            placeholderLabel.text = "Add a new comment"
            placeholderLabel.textColor = UIColor.lightGray
            placeholderLabel.isHidden = false
        }
    }
    @IBOutlet weak var commentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var textViewWidth: NSLayoutConstraint!
    @IBOutlet weak var postButton: UIButton!
    private var keyboardShowToken: Token?
    private var keyboardHideToken: Token?
    @IBOutlet weak var bottomSpaceConstraint: NSLayoutConstraint!
    
    var comments: [Comment] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Post Detail"
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        registerForKeyboardNotifications()
        textViewWidth.constant = UIScreen.main.bounds.width - 80
        print(UIScreen.main.bounds.width - 80)
        commentViewHeight.constant = 50
        initialConfigure()
    }

    private func hideViews(_ isHidden: Bool) {
        postButton.isHidden = isHidden
        bottomStackView.isHidden = isHidden
        commentViewHeight.constant = isHidden ? 45 : 100
    }


    private func registerForKeyboardNotifications() {
        keyboardShowToken = NotificationCenter.default.addObserver(descriptor: SystemNotification.keyboardShowNotification) { keyboardPayload in

            self.hideViews(false)
            self.commentViewHeight.constant = 100
            self.bottomSpaceConstraint.constant = keyboardPayload.beginFrame.height + 1
            UIView.animate(withDuration: keyboardPayload.duration) {
                self.view.layoutIfNeeded()
            }
        }
        keyboardHideToken = NotificationCenter.default.addObserver(descriptor: SystemNotification.keyboardHideNotification) { keyboardPayload in
            self.hideViews(true)
            self.commentViewHeight.constant = 45
            self.bottomSpaceConstraint.constant = 1
            UIView.animate(withDuration: keyboardPayload.duration) {
                self.view.layoutIfNeeded()
            }
        }
    }

    func initialConfigure() {
        view.endEditing(true)
        placeholderLabel.isHidden = false
        commentTextView.text = ""
        postButton.isUserInteractionEnabled = false
        postButton.setTitleColor(.gray, for: .normal)
        bottomSpaceConstraint.constant = 1
        hideViews(true)
    }

    private func postEnable(_ str: String?) {
        postButton.isUserInteractionEnabled = ((str ?? "")?.count ?? 0 > 0)
        postButton.setTitleColor(((str ?? "")?.count ?? 0 > 0) ? .blue : .gray, for: .normal)
    }

    @IBAction func postButtonAction(_ sender: Any) {
        guard !commentTextView.text.isEmpty else { return }
        postButton.isUserInteractionEnabled = false
        commentTextView.resignFirstResponder()

        let commentText = commentTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        comments.append(Comment(image: #imageLiteral(resourceName: "user"), text: commentText))
        tableView.reloadData()
        initialConfigure()
    }
}

extension ViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let str = textView.text as NSString? else { return false }
        let updatedString = str.replacingCharacters(in: range, with: text)
        if updatedString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, !updatedString.isEmpty {
            return false
        }
        placeholderLabel.isHidden = updatedString.count > 0
        postEnable(updatedString)

        return true
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
