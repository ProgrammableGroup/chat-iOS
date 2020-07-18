//
//  serchUserTableviewCell.swift
//  chat-iOS
//
//  Created by jun on 2020/07/18.
//

import UIKit

class SerchUserTableviewCell: UITableViewCell {
    
    @IBOutlet weak var radioImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
       super.awakeFromNib()

    }

     override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)

     }
}
