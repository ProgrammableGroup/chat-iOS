//
//  SelectedUserCollectionViewCell.swift
//  chat-iOS
//
//  Created by jun on 2020/07/18.
//

import UIKit

class SelectedUserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var deleteUserButton: UIButton!
    
    var deleteUserButtonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupProfileImageView()
        self.setupUserNameLabel()
        self.setupDeleteUserButton()
    }
    
    private func setupProfileImageView() {
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        self.profileImageView.layer.masksToBounds = true
    }
    
    private func setupUserNameLabel() {
        self.userNameLabel.adjustsFontSizeToFitWidth = true
        self.userNameLabel.minimumScaleFactor = 0.4
    }
    
    private func setupDeleteUserButton() {
        self.deleteUserButton.layer.cornerRadius = self.deleteUserButton.frame.width / 2
        self.deleteUserButton.layer.masksToBounds = true
    }
    
    @IBAction func tapDeleteUserButton(_ sender: Any) {
        self.deleteUserButtonAction?()
    }
    
}
