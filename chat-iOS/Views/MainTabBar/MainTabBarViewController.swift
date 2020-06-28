//
//  MainTabBarViewController.swift
//  chat-iOS
//
//  Created by jun on 2020/06/28.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    private var presenter: MainTabBarViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedIndex = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let userProfileVC = UserProfileViewBuilder.create()
        let userProfileNavigationController = UINavigationController(rootViewController: userProfileVC)
    
        //TODO:- ここはチャットセレクト画面に遷移すること
        let chatsVC = ChatsViewBuilder.create()
        let chatsNavigationController = UINavigationController(rootViewController: chatsVC)
        
        //TODO:- iOS12以下の場合の画像を用意すること
        if #available(iOS 13.0, *) {
            let chatsTabBarItemImage = UIImage(systemName: "person.circle")
            let chatsTabBarItemSelectedImage = UIImage(systemName: "person.circle.fill")
            
            let userProfileTabBarItemImage = UIImage(systemName: "message")
            let userProfileTabBarItemSelectedImage = UIImage(systemName: "message.fill")
            
            userProfileVC.tabBarItem = UITabBarItem(title: nil, image: userProfileTabBarItemImage, selectedImage: userProfileTabBarItemSelectedImage)
            chatsVC.tabBarItem = UITabBarItem(title: nil, image: chatsTabBarItemImage, selectedImage: chatsTabBarItemSelectedImage)
        } else {
            // Fallback on earlier versions
        }

        self.viewControllers = [chatsNavigationController, userProfileNavigationController]
    }
    
    func inject(with presenter: MainTabBarViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension MainTabBarViewController: MainTabBarViewPresenterOutput {
    
}
