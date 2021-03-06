//
//  UserProfileController.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/06/22.
//

import UIKit

final class UserProfileViewController: UIViewController {
    private var presenter: UserProfileViewPresenterProtocol!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editProfileButton.layer.cornerRadius = 10.0
        self.presenter.didLoadViewController()
    }
    
    @IBAction func tapEditProfileButton(_ sender: Any) {
        self.presenter.didTapEditProfileButton()
    }
    
    func inject(with presenter: UserProfileViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension UserProfileViewController: UserProfileViewPresenterOutput {
    func presentEditProfileViewController() {
        let editProfileVC = EditProfileViewBuilder.create()
        let navigationController = UINavigationController(rootViewController: editProfileVC)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    func setUser() {
    }
    
}
