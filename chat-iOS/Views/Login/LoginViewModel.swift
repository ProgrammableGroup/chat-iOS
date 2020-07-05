//
//  LoginViewModel.swift
//  chat-iOS
//
//  Created by 戸高新也 on 2020/06/18.
//

import FirebaseAuth
import FirebaseFirestore

protocol LoginViewModelProtocol {
    var presenter: LoginViewModelOutput! { get set }
    func signIn(withEmail email: String, password: String)
}

protocol LoginViewModelOutput {
    
}

final class LoginViewModel: LoginViewModelProtocol {
    var presenter: LoginViewModelOutput!
    
    func signIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                
            }
            
        }
    }
}
