//
//  UserProfilePresenter.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/06/22.
//
import Foundation

protocol UserProfileViewPresenterProtocol {
    var view: UserProfileViewPresenterOutput! { get set }
    func didLoadViewController()
    func didTapEditProfileButton()
}

protocol UserProfileViewPresenterOutput {
    func setUserName(userName: String)
    func setUserProfileImage(imageData: Data)
    func presentEditProfileViewController()
}


final class UserProfileViewPresenter: UserProfileViewPresenterProtocol, UserProfileViewModelOutput {
    var view: UserProfileViewPresenterOutput!
    private var model: UserProfileViewModelProtocol
    
    init(model: UserProfileViewModelProtocol) {
        self.model = model
        self.model.presenter = self
    }
    
    func didLoadViewController() {
        self.model.fetchUser()
    }
    func successFetchUser(user: User) {
        self.view.setUserName(userName: user.displayName)
    }
    
    /// 画像取得成功した時呼ばれる関数
    /// - Parameter imageData:  profile画像のデータ
    func successFetchImageData(imageData: Data) {
        self.view.setUserProfileImage(imageData: imageData)
    }
    func didTapEditProfileButton() {
        self.view.presentEditProfileViewController()
    }
}
