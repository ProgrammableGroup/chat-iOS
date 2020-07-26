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
}

final class UserProfileViewModel: UserProfileViewModelProtocol {
    var presenter: UserProfileViewModelOutput!
    var firestore: Firestore!
    private var listner: ListenerRegistration?
    
    init() {
        self.firestore = Firestore.firestore()
        let setting = FirestoreSettings()
        self.firestore.settings = setting
    }
    
    deinit {
        self.listner?.remove()
    }
    
    func fetchUser() {
        //TODO:- 認証が終わったらuidを後で変更すること
        //guard let uid = Auth.auth().currentUser?.uid else { return }
        let userReference = self.firestore.collection("message/v1/users").document("y783WJnXJqDfDED0nBvK")
        self.listner = userReference.addSnapshotListener { (document, error) in
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
            } catch {
                fatalError()
            }
        }
    }
}
