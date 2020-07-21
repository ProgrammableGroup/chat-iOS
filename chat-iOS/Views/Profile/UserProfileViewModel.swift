//
//  UserProfileModel.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/06/22.
//
import Firebase

protocol UserProfileViewModelProtocol {
    var presenter: UserProfileViewModelOutput! { get set }
    func fetchUser()
}

protocol UserProfileViewModelOutput {
    func successFetchUser(user: User)
    func successFetchImageData(imageData: Data)
}

final class UserProfileViewModel: UserProfileViewModelProtocol {
    var presenter: UserProfileViewModelOutput!
    var firestore: Firestore!
    
    init() {
        self.firestore = Firestore.firestore()
        let setting = FirestoreSettings()
        self.firestore.settings = setting
    }
    
    func fetchUser() {
        self.firestore.collection("message/v1/users").document("y783WJnXJqDfDED0nBvK").getDocument { (document, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let document = document, document.exists else {
                print("The document doesn't exist.")
                return
            }
            
            do {
                let user = try Firestore.Decoder().decode(User.self, from: document.data()!)
                self.presenter.successFetchUser(user: user)
                self.downloadProfile(downLoadURL: user.profileImageURL ?? "")
            } catch {
                fatalError()
            }
        
            
        }
        
    }
    
    private func downloadProfile(downLoadURL: String) {
        let httpsReference = Storage.storage().reference(forURL: downLoadURL)
        httpsReference.getData(maxSize: 1 * 512 * 512) { data, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            self.presenter.successFetchImageData(imageData: data)
        }
    }
}
