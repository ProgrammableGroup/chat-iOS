//
//  ChatLogMessageCell.swift
//  chat-iOS
//
//  Created by jun on 2020/06/22.
//

import UIKit

class ChatLogMessageCell: UICollectionViewCell {
    //TODO:- classとして切り出す
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = .clear
        textView.isEditable = false
        return textView
    }()
    
    //TODO:- classとして切り出す
    let textBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    //TODO:- classとして切り出す
    let usersProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemTeal
        imageView.layer.cornerRadius = 25
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
       fatalError()
    }
   
    func setupViews() {
        self.addSubview(textBubbleView)
        self.addSubview(messageTextView)
        self.addSubview(usersProfileImageView)
      
        self.usersProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        self.usersProfileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.usersProfileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.usersProfileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.usersProfileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
   }
}


