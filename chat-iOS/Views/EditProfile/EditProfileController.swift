//
//  EditProfileController.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/07/03.
//

import UIKit

final class EditProfileViewController: UIViewController {
    private var presenter: EditProfileViewPresenterProtocol!
    
    var editProfileButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func inject(with presenter: EditProfileViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension EditProfileViewController: EditProfileViewPresenterOutput {
    
}
