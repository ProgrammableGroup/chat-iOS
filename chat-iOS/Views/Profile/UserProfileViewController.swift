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
        editProfileButton.isEnabled = false
        editProfileButton.layer.cornerRadius = 10.0
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
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
        let editProfileVC = EditProfileViewBuilder.create() as! EditProfileViewController
        editProfileVC.userName = self.profileNameLabel.text ?? ""
        editProfileVC.profileImage = self.profileImageView.image!
        
        let navigationController = UINavigationController(rootViewController: editProfileVC)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    func setUserName(userName: String) {
        DispatchQueue.main.async {
            self.profileNameLabel.text = userName
            self.navigationItem.title = userName
        }
    }
    func setUserProfileImage(imageData: Data) {
        DispatchQueue.main.async {
            self.editProfileButton.isEnabled = true
            self.profileImageView.image = UIImage(data: imageData)!
            self.profileImageView.alpha = 0
            UIView.animate(withDuration: 0.25, animations: {
                self.profileImageView.alpha = 1
            })
        }
    }
}
