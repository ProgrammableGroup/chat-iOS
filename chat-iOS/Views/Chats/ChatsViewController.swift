//
//  ChatsViewController.swift
//  chat-iOS
//
//  Created by jun on 2020/06/22.
//

import UIKit

final class ChatsViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    private var presenter: ChatsViewPresenterProtocol!
    
    @IBOutlet weak var chatsCollectionView: UICollectionView!
    @IBOutlet weak var messageInputView: UIView!
    
    
    
    var message: [String] = ["こんにちは", "こんにちは😊", "どうですか", "いいですね\nいいですね☀️",
                            "I'm told that you were a very,\n very interesting person, by analogy.",
                            "...", "123456789!@#$%^&*()_+={}|:<>?;'[]`~;',./", "そ\nし\nた\nら\nね\n.",
                            " ", "うん\nうん"]
    
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChatsCollectionView()
    }
    
    func setupChatsCollectionView() {
        self.chatsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.chatsCollectionView.delegate = self
        self.chatsCollectionView.dataSource = self
        self.chatsCollectionView.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellID)
        self.chatsCollectionView.delaysContentTouches = false
    }

    func inject(with presenter: ChatsViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension ChatsViewController: ChatsViewPresenterOutput {
    
}

extension ChatsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return message.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ChatLogMessageCell
       
        cell.messageTextView.text = message[indexPath.item]
       
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: message[indexPath.item]).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
       
        //TODO:- 自分のチャットか相手のチャットで分岐する
        if indexPath.item % 2 == 0 {
            cell.messageTextView.frame = CGRect(x: 66 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            cell.textBubbleView.frame = CGRect(x: 66, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 16)
          
            cell.usersProfileImageView.isHidden = false
            cell.textBubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        } else {
          
            cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 16, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            cell.textBubbleView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 8 - 16, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 16)
          
            cell.usersProfileImageView.isHidden = true
            cell.textBubbleView.backgroundColor = UIColor(red: 0, green: 137 / 255, blue: 249 / 255, alpha: 1)
            cell.messageTextView.textColor = .white
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
       let size = CGSize(width: 250, height: 1000)
       let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
       let estimatedFrame = NSString(string: message[indexPath.item]).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
       
       return CGSize(width: self.view.frame.width, height: estimatedFrame.height + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
    }
}

class ChatLogMessageCell: UICollectionViewCell {
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = .clear
        textView.isEditable = false
        return textView
    }()
   
    let textBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
   
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
