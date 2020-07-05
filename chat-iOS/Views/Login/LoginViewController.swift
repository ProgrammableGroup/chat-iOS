//
//  LoginViewController.swift
//  chat-iOS
//
//  Created by 戸高新也 on 2020/06/16.
//

import UIKit

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
    }

    func inject(with presenter: LoginViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
    
    func didTapSignInButton(email: String, password: String){
        presenter.didTapSignInButton(email: email, password: password)
    }
}

extension LoginViewController: LoginViewPresenterOutput {

}
