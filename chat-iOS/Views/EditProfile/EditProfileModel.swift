//
//  EditProfileModel.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/07/03.
//
import Firebase

protocol EditProfileModelProtocol {
    var presenter: EditProfileModelOutput! { get set }
    func saveProfile()
}

protocol EditProfileModelOutput {
    
}

final class EditProfileModel: EditProfileModelProtocol {
    var presenter: EditProfileModelOutput!
    
    //TODO:- セーブする処理を書くこと
    //MARK:- ここでセーブする処理を書く
    func saveProfile() {
//        let storage = Storage.storage().reference(forURL: "gs://mapapp6-bf5a1.appspot.com")
//        let imageRef = storage.child("profileImage").child("\(user.uid).jpeg")
//        var ProfileImageData: Data = Data()
//        if imageView.image != nil {
//
//        //画像を圧縮
//        ProfileImageData = (imageView.image?.jpegData(compressionQuality: 0.01))!
//
//        }
//        imageRef.putData(ProfileImageData, metadata: nil) { (metaData, error) in
//
//            //エラーであれば
//            if error != nil {
//
//                print(error.debugDescription)
//                return  //これより下にはいかないreturn
//            }
//        }
    }
}

