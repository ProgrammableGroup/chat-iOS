//
//  MainTabBarBuilder.swift
//  chat-iOS
//
//  Created by jun on 2020/06/28.
//

import UIKit

struct MainTabBarViewBuilder {
    static func create() -> UIViewController {
        guard let MainTabBarViewController = MainTabBarViewController.loadFromStoryboard() as? MainTabBarViewController else {
            fatalError("fatal: Failed to initialize the MainTabBarViewController")
        }
        let model = MainTabBarModel()
        let presenter = MainTabBarViewPresenter(model: model)
        MainTabBarViewController.inject(with: presenter)
        return MainTabBarViewController
    }
}
