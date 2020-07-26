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
    func setUserProfileImage(imageURL: URL)
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
        guard let URLStr = user.profileImageURL else { return }
        guard let encodeURLStr = URLStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: encodeURLStr) else { return }
        self.view.setUserProfileImage(imageURL: url)
    }
    func didTapEditProfileButton() {
        self.view.presentEditProfileViewController()
    }
}
