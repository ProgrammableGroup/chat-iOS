//
//  SelectChatBuilder.swift
//  chat-iOS
//
//  Created by 松木周 on 2020/07/15.
//

import UIKit

struct SelectChatViewBuilder {
    static func create() -> UIViewController {
        guard let selectChatViewController = SelectChatViewController.loadFromStoryboard() as? SelectChatViewController else {
            fatalError("fatal: Failed to initialize the ChatsViewController")
        }
        let model = SelectChatModel()
        let presenter = SelectChatViewPresenter(model: model)
        selectChatViewController.inject(with: presenter)
        return selectChatViewController
    }
}
