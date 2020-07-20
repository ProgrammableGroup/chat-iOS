//
//  EditProfileController.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/07/03.
//

import UIKit
import Firebase

final class EditProfileViewController: UIViewController {
    private var presenter: EditProfileViewPresenterProtocol!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var changePhotoButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        setupNameTextField()
        setupImageView()
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
    
    func setupNameTextField() {
        self.nameTextField.addBorderBottom(borderWidth: 1.0, color: .gray)
    }
    
    func setupImageView() {
        self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
    }
    
    //TODO:- NaviBarでバツボタン押されたときの処理をかく
    @objc func tapStopEditProfileButton() {
        print("キャンセルボタンタップされた")
        
        self.presenter.didTapStopEditProfileButton()
    }
    
    //TODO: ここでデータをセーブする処理を行う
    @objc func tapSaveEditProfileButton() {
        print("セーブボタンタップされた")
      
        self.presenter.didTapSaveEditProfileButton()
    }
    
    @IBAction func tapChangePhotoButton(_ sender: Any) {
        self.presenter.didTapChangePhotoButton()
    }
}

extension EditProfileViewController: EditProfileViewPresenterOutput {
    func dismissEditProfileViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showActionSheet() {
        let alertSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let takeAction = UIAlertAction(title: "写真を撮影", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            print("写真撮影タップされた")
            self.presenter.didTapTakePhotoAction()
        })
        let pickAction = UIAlertAction(title: "写真を選択", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            print("写真選択タップされた")
            self.presenter.didTapPickupPhotoAction()
        })
        let deleteAction = UIAlertAction(title: "写真を削除", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) in
            print("写真削除タップされた")
        })
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) in
        })
        
        alertSheet.addAction(takeAction)
        alertSheet.addAction(pickAction)
        alertSheet.addAction(deleteAction)
        alertSheet.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alertSheet, animated: true, completion: nil)
        }
    }
    
    
    func showImagePickerControllerAsPhotoLibrary() {
        let photoPickerVC = UIImagePickerController()
        photoPickerVC.sourceType = .photoLibrary
        photoPickerVC.delegate = self
    
        DispatchQueue.main.async {
            self.present(photoPickerVC, animated: true, completion: nil)
        }
    }
    
    func showImagePickerControllerAsCamera() {
        let photoPickerVC = UIImagePickerController()
        photoPickerVC.sourceType = .camera
        photoPickerVC.delegate = self
        
        DispatchQueue.main.async {
            self.present(photoPickerVC, animated: true, completion: nil)
        }
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // キャンセルボタンを押された時に呼ばれる
        print("イメージピッカーでキャンセル押された")
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickerImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }
        
        self.imageView.image = pickerImage
        picker.dismiss(animated: true)
    }
}



