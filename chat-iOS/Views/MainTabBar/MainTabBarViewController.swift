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

        let selectChatVC = SelectChatViewBuilder.create()
        let chatsNavigationController = UINavigationController(rootViewController: selectChatVC)
        
        //TODO:- iOS12以下の場合の画像を用意すること
        if #available(iOS 13.0, *) {
            let chatsTabBarItemImage = UIImage(systemName: "message")
            let chatsTabBarItemSelectedImage = UIImage(systemName: "message.fill")
            
            let userProfileTabBarItemImage = UIImage(systemName: "person.circle")
            let userProfileTabBarItemSelectedImage = UIImage(systemName: "person.circle.fill")
            
            userProfileVC.tabBarItem = UITabBarItem(title: nil, image: userProfileTabBarItemImage, selectedImage: userProfileTabBarItemSelectedImage)
            selectChatVC.tabBarItem = UITabBarItem(title: nil, image: chatsTabBarItemImage, selectedImage: chatsTabBarItemSelectedImage)
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
