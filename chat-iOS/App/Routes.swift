//
//  Routes.swift
//  chat-iOS
//
//  Created by Ren Matsushita on 2020/06/15.
//

import UIKit

struct Routes {
    static func decideRootViewController() -> UIViewController {
        //TODO:- ログインをしてるかの処理を書くこと
        let isAuth = true
        
        if isAuth { return MainTabBarViewBuilder.create() }
        return LoginViewBuilder.create()
    }
}
