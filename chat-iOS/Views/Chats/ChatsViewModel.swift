//
//  ChatsViewModel.swift
//  chat-iOS
//
//  Created by jun on 2020/06/22.
//

import Firebase

protocol ChatsViewModelProtocol {
    var presenter: ChatsViewModelOutput! { get set }
    var firestore: Firestore! { get set }
    
    func setUpFirestore()    
}

protocol ChatsViewModelOutput {
    
}

final class ChatsViewModel: ChatsViewModelProtocol {
    var firestore: Firestore!
    var presenter: ChatsViewModelOutput!
    
    func setUpFirestore() {
        self.firestore = Firestore.firestore()
        let settings = FirestoreSettings()
        self.firestore.settings = settings
    }
}
