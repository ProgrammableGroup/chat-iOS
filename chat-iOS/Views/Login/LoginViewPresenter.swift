//
//  LoginViewPresenter.swift
//  chat-iOS
//
//  Created by 戸高新也 on 2020/06/18.
//

import FirebaseFirestore
import FirebaseAuth

protocol LoginViewPresenterProtocol {
    var view: LoginViewPresenterOutput! { get set }
    func didTapSignInButton(email: String, password: String)
}

protocol LoginViewPresenterOutput: class {
    func transitionToMainTabBar(withUser user: User)
    func showAlert(withMessage message: String)
}

final class LoginViewPresenter: LoginViewPresenterProtocol, LoginViewModelOutput {
    var view: LoginViewPresenterOutput!
    private var model: LoginViewModelProtocol
    
    init(model: LoginViewModelProtocol) {
        self.model = model
        self.model.presenter = self
    }
    
    func didTapSignInButton(email: String, password: String) {
        model.signIn(withEmail: email, password: password)
    }
    
    func successSignIn(withUser user: User) {
        DispatchQueue.main.async { [weak self] in
            self?.view.transitionToMainTabBar(withUser: user)
        }
    }
    
    func onError(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.view.showAlert(withMessage: error.localizedDescription)
        }
    }
}

