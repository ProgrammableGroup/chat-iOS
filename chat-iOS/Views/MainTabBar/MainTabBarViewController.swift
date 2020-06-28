//
//  MainTabBarViewController.swift
//  chat-iOS
//
//  Created by jun on 2020/06/28.
//

import UIKit

final class MainTabBarViewController: UIViewController {
    private var presenter: MainTabBarViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func inject(with presenter: MainTabBarViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension MainTabBarViewController: MainTabBarViewPresenterOutput {
    
}
