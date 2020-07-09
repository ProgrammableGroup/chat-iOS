//
//  UserProfilePresenter.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/06/22.
//

protocol UserProfileViewPresenterProtocol {
    var view: UserProfileViewPresenterOutput! { get set }
    func didLoadViewController()
}

protocol UserProfileViewPresenterOutput {
    func setUser()
}

final class UserProfileViewPresenter: UserProfileViewPresenterProtocol, UserProfileViewModelOutput {
    var view: UserProfileViewPresenterOutput!
    private var model: UserProfileViewModelProtocol
    
    init(model: UserProfileViewModelProtocol) {
        self.model = model
        self.model.presenter = self
    }
    
    func didLoadViewController() {
        model.fetchUser()
    }
    func successFetchUser() {
        view.setUser()
    }
}
