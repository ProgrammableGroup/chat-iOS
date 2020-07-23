//
//  SelectChatModel.swift
//  chat-iOS
//
//  Created by 松木周 on 2020/07/15.
//

import Firebase

protocol SelectChatModelProtocol {
    var presenter: SelectChatModelOutput! { get set }
    func setUpFirestore()
    func fetchCurrentChatRoom()
}

protocol SelectChatModelOutput: class {
    func successFetchCurrentChatRooms(currentChatRooms rooms: [Room])
    func onError(error: Error?)
}

final class SelectChatModel: SelectChatModelProtocol {

    weak var presenter: SelectChatModelOutput!
    private var firestore: Firestore!
    private var listener: ListenerRegistration?

    init() {
        self.setUpFirestore()
    }

    deinit {
        listener?.remove()
    }

    func setUpFirestore() {
        self.firestore = Firestore.firestore()
        let settings = FirestoreSettings()
        self.firestore.settings = settings
    }

    func fetchCurrentChatRoom() {

        guard let curretnUserId = Auth.auth().currentUser?.uid else { return }

        self.listener = self.firestore.collection("rooms").whereField("members", arrayContains: curretnUserId).addSnapshotListener { [weak self] (documentSnapshot, error) in

            if let error = error {
                self?.presenter.onError(error: error)
                return
            }

            guard let documents = documentSnapshot?.documents else {
                print("The document doesn't exist.")
                return
            }

            let rooms = documents.compactMap { queryDocumentSnapshot -> Room? in
                return try? queryDocumentSnapshot.data(as: Room.self)
            }

            self?.presenter.successFetchCurrentChatRooms(currentChatRooms: rooms)
        }
        
    }

}

