//
//  SelectChatTableViewCell.swift
//  chat-iOS
//
//  Created by 松木周 on 2020/07/15.
//

import UIKit

class SelectChatTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var lastMessageTimeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func generateCell(withRoom room: Room) {
        userNameLabel.text = room.name
        lastMessageLabel.text = room.name
        //TODO:- Storageから画像を取得して表示する
    }
    
}
