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
    
    public func changeFillImageRadioImageView() {
        if #available(iOS 13.0, *) {
            self.radioImageView.image = UIImage(systemName: "checkmark.seal.fill")
            self.radioImageView.tintColor = .systemGreen
        } else {
            // Fallback on earlier versions
        }
    }
    
    public func changeNotFillImageRadioImageView() {
        if #available(iOS 13.0, *) {
            self.radioImageView.image = UIImage(systemName: "checkmark.seal")
            self.radioImageView.tintColor = .systemGray
        } else {
            // Fallback on earlier versions
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}