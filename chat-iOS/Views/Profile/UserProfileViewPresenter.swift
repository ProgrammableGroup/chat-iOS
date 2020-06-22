//
//  UserProfilePresenter.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/06/22.
//

protocol UserProfileViewPresenterProtocol {
    var view: UserProfileViewPresenterOutput! { get set }
}

protocol UserProfileViewPresenterOutput {
    
}

final class UserProfileViewPresenter: UserProfileViewPresenterProtocol, UserProfileViewModelOutput {
    var view: UserProfileViewPresenterOutput!
    private var model: UserProfileViewModelProtocol
    
    init(model: UserProfileViewModelProtocol) {
        self.model = model
    }
}
