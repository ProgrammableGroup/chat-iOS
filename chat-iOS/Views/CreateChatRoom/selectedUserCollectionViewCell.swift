//
//  selectedUserCollectionViewCell.swift
//  chat-iOS
//
//  Created by jun on 2020/07/18.
//

import UIKit

class SelectedUserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var deleteUserButton: UIButton!
    
    override func awakeFromNib() {
       super.awakeFromNib()

    }
}
