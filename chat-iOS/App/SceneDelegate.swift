//
//  SceneDelegate.swift
//  chat-iOS
//
//  Created by Ren Matsushita on 2020/06/15.
//

import UIKit
import Firebase

@available(iOS 13.0, *)
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
    }
}
