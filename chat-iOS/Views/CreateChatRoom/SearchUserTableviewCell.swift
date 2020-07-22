//
//  SearchUserTableviewCell.swift
//  chat-iOS
//
//  Created by jun on 2020/07/18.
//

import UIKit

class SearchUserTableviewCell: UITableViewCell {
    
    @IBOutlet weak var radioImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupRadioImageView()
        self.setupProfileImageView()
        self.setupUserNameLabel()
    }
    
    private func setupRadioImageView() {
        self.radioImageView.layer.cornerRadius = self.radioImageView.frame.width / 2
        self.radioImageView.layer.masksToBounds = true
    }
    
    private func setupProfileImageView() {
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        self.profileImageView.layer.masksToBounds = true
    }
    
    private func setupUserNameLabel() {
        self.userNameLabel.adjustsFontSizeToFitWidth = true
        self.userNameLabel.minimumScaleFactor = 0.4
    }
    
    func configure(with user: User, isSelected: Bool) {
        self.userNameLabel.text = user.displayName
            
        if #available(iOS 13.0, *) {
            radioImageView.image = isSelected ? UIImage(systemName: "checkmark.seal.fill") : UIImage(systemName: "checkmark.seal")
            radioImageView.tintColor = isSelected ? .systemGreen : .systemGray
        } else {
            //TODO:- iOS12以下の画像を用意すること
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
