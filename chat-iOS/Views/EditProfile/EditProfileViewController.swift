//
//  EditProfileController.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/07/03.
//

import UIKit

final class EditProfileViewController: UIViewController {
    private var presenter: EditProfileViewPresenterProtocol!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var changePhotoButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.gray.cgColor
        border.frame = CGRect(x: 0, y: nameTextField.frame.size.height - width, width:  nameTextField.frame.size.width, height: 1)
        
        border.borderWidth = width
        
        nameTextField.layer.addSublayer(border)
    }
    
    func inject(with presenter: EditProfileViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
    
    func setupNavigationItem() {
        self.navigationItem.title = "Edit Profile"
        let stopItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(tapStopEditProfileButton))
        stopItem.tintColor = .black
        self.navigationItem.leftBarButtonItem = stopItem
        let saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(tapSaveEditProfileButton))
        saveItem.tintColor = .black
        self.navigationItem.rightBarButtonItem = saveItem
    }
    
    //TODO:- NaviBarでバツボタン押されたときの処理をかく
    @objc func tapStopEditProfileButton() {
        print("キャンセルボタンタップされた")
        self.dismiss(animated: true, completion: nil) //この処理はmvpで行う
    }
    //TODO: ここでデータをセーブする処理を行う
    @objc func tapSaveEditProfileButton() {
        print("セーブボタンタップされた")
    }
    
    @IBAction func tapChangePhotoButton(_ sender: Any) {
        
        let alertSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let takeAction = UIAlertAction(title: "写真を撮影", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
        })
        let pickAction = UIAlertAction(title: "写真を選択", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
        })
        let deleteAction = UIAlertAction(title: "写真を削除", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) in
        })
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) in
        })
        
        alertSheet.addAction(takeAction)
        alertSheet.addAction(pickAction)
        alertSheet.addAction(deleteAction)
        alertSheet.addAction(cancelAction)
        
        self.present(alertSheet, animated: true, completion: nil)
    }
}

extension EditProfileViewController: EditProfileViewPresenterOutput {
    
}
