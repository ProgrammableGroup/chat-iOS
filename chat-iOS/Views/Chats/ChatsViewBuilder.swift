//
//  ChatsViewBuilder.swift
//  chat-iOS
//
//  Created by jun on 2020/06/22.
//

import UIKit

struct ChatsViewBuilder {
    static func create() -> UIViewController {
        guard let chatsViewController = ChatsViewController.loadFromStoryboard() as? ChatsViewController else {
            fatalError("fatal: Failed to initialize the ChatsViewController")
        }
        let model = ChatsViewModel()
        let presenter = ChatsViewPresenter(model: model)
        chatsViewController.inject(with: presenter)
        return chatsViewController
    }
}
