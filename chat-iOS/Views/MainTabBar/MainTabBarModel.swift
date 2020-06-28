//
//  MainTabBarModel.swift
//  chat-iOS
//
//  Created by jun on 2020/06/28.
//

protocol MainTabBarModelProtocol {
    var presenter: MainTabBarModelOutput! { get set }
}

protocol MainTabBarModelOutput {
    
}

final class MainTabBarModel: MainTabBarModelProtocol {
    var presenter: MainTabBarModelOutput!
}
