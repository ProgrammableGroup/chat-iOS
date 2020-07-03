//
//  AuthTopViewController.swift
//  chat-iOS
//
//  Created by 戸高新也 on 2020/06/16.
//

import UIKit

class AuthTopViewController: UIViewController {
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        let loginViewController = LoginViewBuilder.create()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
}
