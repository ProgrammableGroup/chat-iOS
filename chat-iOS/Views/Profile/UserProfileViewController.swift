//
//  UserProfileController.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/06/22.
//

import UIKit
import Nuke

final class UserProfileViewController: UIViewController {
    private var presenter: UserProfileViewPresenterProtocol!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupEditProfileButton()
        self.setupProfileImageView()
        self.presenter.didLoadViewController()
    }
    
    func setupEditProfileButton() {
        editProfileButton.isEnabled = false
        editProfileButton.layer.cornerRadius = 10.0
    }
    
    func setupProfileImageView() {
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
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
    func setUserProfileImage(imageURL: URL) {
        //TODO:- URLの確認とか画像の用意とかすること
        var defaultImage = UIImage()
        if #available(iOS 13.0, *) {
            defaultImage = UIImage(systemName: "person.circle.fill") ?? UIImage()
        } else {
            // Fallback on earlier versions
        }
        DispatchQueue.main.async {
            self.editProfileButton.isEnabled = true
            let options = ImageLoadingOptions(placeholder: defaultImage, failureImage: defaultImage)
            loadImage(with: imageURL, options: options, into: self.profileImageView, progress: nil, completion: nil)
        }
    }
}
