//
//  MainTabBarPresenter.swift
//  chat-iOS
//
//  Created by jun on 2020/06/28.
//

protocol MainTabBarViewPresenterProtocol {
    var view: MainTabBarViewPresenterOutput! { get set }
}

protocol MainTabBarViewPresenterOutput {
    
}

final class MainTabBarViewPresenter: MainTabBarViewPresenterProtocol, MainTabBarModelOutput {
    var view: MainTabBarViewPresenterOutput!
    private var model: MainTabBarModelProtocol
    
    init(model: MainTabBarModelProtocol) {
        self.model = model
    }
}
