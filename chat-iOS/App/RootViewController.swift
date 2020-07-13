//
//  RootViewController.swift
//  chat-iOS
//
//  Created by 戸高新也 on 2020/07/13.
//

import UIKit
import FirebaseAuth

class RootViewController: UIViewController {
    
    static var instance: RootViewController {
        return UIApplication.shared.keyWindow!.rootViewController as! RootViewController
    }
    
    enum ViewType {
        case login
        case main
    }

    private var viewType: ViewType? {
        didSet {
            guard let type = viewType, oldValue != type  else { return }
            switch type {
            case .login:
                currentViewController = UINavigationController(rootViewController: AuthTopViewBuilder.create())
            case .main:
                currentViewController = MainTabBarViewBuilder.create()
            }
        }
    }

    private(set) var currentViewController: UIViewController? {
        didSet {
            guard let currentViewController = currentViewController else { return }

            addChild(currentViewController)
            view.addSubview(currentViewController.view)
            currentViewController.didMove(toParent: self)
            currentViewController.view.frame = view.bounds

            guard let oldViewController = oldValue else { return }

            view.sendSubviewToBack(currentViewController.view)
            UIView.transition(from: oldViewController.view, to: currentViewController.view, duration: 0.35, options: .transitionCrossDissolve) { _ in
                oldViewController.willMove(toParent: nil)
                oldViewController.view.removeFromSuperview()
                oldViewController.removeFromParent()
            }
        }
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser?.uid == nil {
            self.viewType = .login
        } else {
            self.viewType = .main
        }
    }
    
    func transition(to type: ViewType) {
        self.viewType = type
    }
}
