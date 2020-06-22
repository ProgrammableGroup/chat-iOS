//
//  Routes.swift
//  chat-iOS
//
//  Created by Ren Matsushita on 2020/06/15.
//

import UIKit

struct Routes {
    static func decideRootViewController() -> UIViewController {
        return ChatsViewBuilder.create()
    }
}
