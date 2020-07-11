//
//  LoginViewModel.swift
//  chat-iOS
//
//  Created by 戸高新也 on 2020/06/18.
//

import FirebaseFirestore
import FirebaseAuth

protocol LoginModelProtocol {
    var presenter: LoginModelOutput! { get set }
    func signIn(withEmail email: String, password: String)
}

protocol LoginModelOutput: class {
    func successSignIn(withUser user: User)
    func onError(error: Error)
}

final class LoginModel: LoginModelProtocol {
    weak var presenter: LoginModelOutput!
    
    func signIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let err = error {
                self?.presenter.onError(error: err)
            }
            
            if let uid = result?.user.uid {
                let userReference = Firestore.firestore()
                    .collection("message").document("v1")
                    .collection("users").document(uid)
                
                userReference.getDocument { (snapshot, error) in
                    if let err = error {
                        self?.presenter.onError(error: err)
                    }
                    
                    if let snapshot = snapshot {
                        do {
                            guard let user = try snapshot.data(as: User.self) else { return }
                            self?.presenter.successSignIn(withUser: user)
                        } catch let err {
                            self?.presenter.onError(error: err)
                        }
                    }
                }
            }
        }
    }
}
