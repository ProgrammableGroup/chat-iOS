//
//  LoginViewController.swift
//  chat-iOS
//
//  Created by 戸高新也 on 2020/06/16.
//

import UIKit
import FirebaseAuth

final class LoginViewController: UIViewController {
    private var presenter: LoginViewPresenterProtocol!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func didTapSignInButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        didTapSignInButton(email: email, password: password)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard)))
    }
    
    @objc private func handleDismissKeyboard() {
        view.endEditing(true)
    }

    func inject(with presenter: LoginViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
    
    func didTapSignInButton(email: String, password: String) {
        presenter.didTapSignInButton(email: email, password: password)
    }
}

extension LoginViewController: LoginViewPresenterOutput {
    
    func transitionToMainTabBar(withUser user: User) {
        //TODO:- userを使ってMainTabBarへの遷移処理を書く
        print(user.displayName)
    }
    
    func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "エラーが発生しました", message: message, preferredStyle: .alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(defaultAction)
        present(alert, animated: false, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
