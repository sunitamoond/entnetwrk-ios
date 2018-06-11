//
//  Keyboard+Notification.swift
//  entnetwrk-ios
//
//  Created by Sunita Moond on 11/06/18.
//  Copyright © 2018 Sunita. All rights reserved.
//

import Foundation
import UIKit

struct NotificationDescriptor<A> {
    let name: Notification.Name
    let convert: (Notification) -> A
}

extension NotificationCenter {
    func addObserver<A>(descriptor: NotificationDescriptor<A>, block: @escaping (A) -> ()) -> Token {
        let token = addObserver(forName: descriptor.name, object: nil, queue: nil) { (note) in
            block(descriptor.convert(note))
        }

        return Token(token: token, center: self)
    }
}

class Token {
    let center: NotificationCenter
    let token: NSObjectProtocol

    init(token: NSObjectProtocol, center: NotificationCenter) {
        self.token = token
        self.center = center
    }

    deinit {
        center.removeObserver(token)
    }
}

struct KeyboardPayload {
    let beginFrame: CGRect
    let duration: TimeInterval
}

extension KeyboardPayload {
    init(note: Notification) {
        guard let info = note.userInfo,
            let keyboardFrameValue = info[UIKeyboardFrameEndUserInfoKey] as? CGRect
            else {
                self.beginFrame = CGRect.zero
                self.duration = 0

                return
        }
        self.beginFrame = keyboardFrameValue
        self.duration = info[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
    }
}

struct SystemNotification {
    static let keyboardShowNotification = NotificationDescriptor(name: .UIKeyboardWillShow, convert: KeyboardPayload.init)
    static let keyboardHideNotification = NotificationDescriptor(name: .UIKeyboardWillHide, convert: KeyboardPayload.init)
}

