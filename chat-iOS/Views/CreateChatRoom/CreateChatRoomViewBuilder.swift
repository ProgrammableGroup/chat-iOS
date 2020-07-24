//
//  CreateChatRoomViewBuilder.swift
//  chat-iOS
//
//  Created by jun on 2020/07/18.
//

import UIKit

struct CreateChatRoomViewBuilder {
    static func create() -> UIViewController {
        guard let createChatRoomViewController = CreateChatRoomViewController.loadFromStoryboard() as? CreateChatRoomViewController else {
            fatalError("fatal: Failed to initialize the CreateChatRoomViewController")
        }
        let model = CreateChatRoomModel()
        let presenter = CreateChatRoomViewPresenter(model: model)
        createChatRoomViewController.inject(with: presenter)
        return createChatRoomViewController
    }
}
