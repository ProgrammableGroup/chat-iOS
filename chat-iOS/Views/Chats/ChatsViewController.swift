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
    @IBOutlet weak var messageInputViewButtomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
 
    var transScripts: [Transcript] = Array()
    
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChatsCollectionView()
        setupMessageInputView()
        setupNotificationCenter()
    }
    
    func setupChatsCollectionView() {
        self.chatsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.chatsCollectionView.delegate = self
        self.chatsCollectionView.dataSource = self
        self.chatsCollectionView.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellID)
        self.chatsCollectionView.delaysContentTouches = false
    }
    
    func setupMessageInputView() {
        self.inputTextView.layer.cornerRadius = 8
        self.inputTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.inputTextView.layer.borderWidth = 1
        self.inputTextView.layer.masksToBounds = true
        
        if #available(iOS 13.0, *) {
            let image = UIImage(systemName: "paperplane.fill")
            self.sendButton.setImage(image, for: .normal)
        } else {
            //TODO: 送信ボタンの画像を用意する
        }
        self.sendButton.tintColor = .systemTeal
    }
    
    func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShowNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHideNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// キーボードが登場した時の処理。messageInputViewのBottomConstraintをキーボードの高さ分上げる
    @objc func keyboardWillShowNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboard = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        self.messageInputViewButtomConstraint.constant = -keyboard.cgRectValue.height + self.view.safeAreaInsets.bottom
        UIView.animate(withDuration: 1.0, animations: { self.view.layoutIfNeeded() })
    }
    
    /// キーボードが隠れた時の処理。messageInputViewのBottomConstraintを元に戻す
    @objc func keyboardWillHideNotification(notification: NSNotification) {
        guard notification.userInfo != nil else { return }
        
        self.messageInputViewButtomConstraint.constant = 0
        UIView.animate(withDuration: 1.0, animations: { self.view.layoutIfNeeded() })
    }

    func inject(with presenter: ChatsViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension ChatsViewController: ChatsViewPresenterOutput {
    func updateChatsCollectionView(transScripts: [Transcript]) {
        self.transScripts = transScripts
        
        DispatchQueue.main.async { self.chatsCollectionView.reloadData() }
    }
}

extension ChatsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.transScripts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ChatLogMessageCell
        let messageTexst = self.transScripts[indexPath.item].text ?? ""
        cell.messageTextView.text = messageTexst
       
        let estimatedMessageFrame = messageTexst.estimatedFrame()
       
        //FIXME:- fromが自分のidかどうかで分岐するので式の右辺をuidに変更する
        if self.transScripts[indexPath.item].from == "self.uid" {
            cell.messageTextView.frame = CGRect(x: 66 + 8, y: 0, width: estimatedMessageFrame.width + 16, height: estimatedMessageFrame.height + 20)
            cell.textBubbleView.frame = CGRect(x: 66, y: 0, width: estimatedMessageFrame.width + 16 + 8, height: estimatedMessageFrame.height + 16)
          
            cell.usersProfileImageView.isHidden = false
            cell.textBubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        } else {
            cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedMessageFrame.width - 16 - 16, y: 0, width: estimatedMessageFrame.width + 16, height: estimatedMessageFrame.height + 20)
            cell.textBubbleView.frame = CGRect(x: view.frame.width - estimatedMessageFrame.width - 16 - 8 - 16, y: 0, width: estimatedMessageFrame.width + 16 + 8, height: estimatedMessageFrame.height + 16)
          
            cell.usersProfileImageView.isHidden = true
            cell.textBubbleView.backgroundColor = UIColor(red: 0, green: 137 / 255, blue: 249 / 255, alpha: 1)
            cell.messageTextView.textColor = .white
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let messageTexst = self.transScripts[indexPath.item].text ?? ""
        let estimatedMessageFrame = messageTexst.estimatedFrame()
        return CGSize(width: self.view.frame.width, height: estimatedMessageFrame.height + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard self.inputTextView.isFirstResponder else { return }
        self.inputTextView.resignFirstResponder()
    }
}
