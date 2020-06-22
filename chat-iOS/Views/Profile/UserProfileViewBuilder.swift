//
//  UserProfiles.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/06/22.
//

import UIKit

struct UserProfileViewBuilder {
    static func create() -> UIViewController {
        guard let userProfileViewController = UserProfileViewController.loadFromStoryboard() as? UserProfileViewController else {
            fatalError("fatal: Failed to initialize the SampleViewController")
        }
        let model = UserProfileViewModel()
        let presenter = UserProfileViewPresenter(model: model)
        userProfileViewController.inject(with: presenter)
        return userProfileViewController
    }
}
