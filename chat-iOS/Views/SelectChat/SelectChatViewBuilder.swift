//
//  SelectChatViewBuilder.swift
//  chat-iOS
//
//  Created by 松木周 on 2020/06/21.
//

import UIKit

struct SelectChatViewBuilder {
    static func create() -> UIViewController {
        guard let selectChatViewController = SelectChatViewController.loadFromStoryboard() as? SelectChatViewController else {
            fatalError("fatal: Failed to initialize the SampleViewController")
        }
        return selectChatViewController
    }
}
