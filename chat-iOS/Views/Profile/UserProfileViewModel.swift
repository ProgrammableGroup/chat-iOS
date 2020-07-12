//
//  UserProfileModel.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/06/22.
//

protocol UserProfileViewModelProtocol {
    var presenter: UserProfileViewModelOutput! { get set }
    func fetchUser()
}

protocol UserProfileViewModelOutput {
    func successFetchUser()
}

final class UserProfileViewModel: UserProfileViewModelProtocol {
    var presenter: UserProfileViewModelOutput!
    
    func fetchUser() {
        self.presenter.successFetchUser()
    }
}
