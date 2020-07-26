//
//  EditProfileBuilder.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/07/03.
//

import UIKit

struct EditProfileViewBuilder {
    static func create() -> UIViewController {
        guard let editProfileViewController = EditProfileViewController.loadFromStoryboard() as? EditProfileViewController else {
            fatalError("fatal: Failed to initialize the EditProfileViewController")
        }
        let model = EditProfileModel()
        let presenter = EditProfileViewPresenter(model: model)
        editProfileViewController.inject(with: presenter)
        return editProfileViewController
    }
}
