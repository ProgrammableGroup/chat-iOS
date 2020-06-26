//
//  UIViewController+loadFromStoryboard.swift
//  chat-iOS
//
//  Created by Ren Matsushita on 2020/06/15.
//

import UIKit

public extension UIViewController {
    // 命名規則がおかしいとここで落ちます。
    // 命名規則は(例 SignUpの場合)SignUp.storyboard と SignUpViewController.swiftにしてください
    class func loadFromStoryboard<T>() -> T where T: UIViewController {
        let storyboard = UIStoryboard(name: NSStringFromClass(self).components(separatedBy: ".").last!.removeAt(text: "ViewController")!, bundle: nil)
        return storyboard.instantiateInitialViewController() as! T
    }
}
