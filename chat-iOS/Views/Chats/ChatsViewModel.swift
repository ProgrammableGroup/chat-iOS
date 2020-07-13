//
//  ChatsViewModel.swift
//  chat-iOS
//
//  Created by jun on 2020/06/22.
//

import Firebase

protocol ChatsViewModelProtocol {
    var presenter: ChatsViewModelOutput! { get set }
    
    func setUpFirestore()
    func fetchTransScript()
    
    func sendMessage(messageText: String)
}

protocol ChatsViewModelOutput: class {
    func successFetchTransScript(transScripts: [Transcript])
    func successSendMessage()
}

final class ChatsViewModel: ChatsViewModelProtocol {
    weak var presenter: ChatsViewModelOutput!
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
    
    func fetchTransScript() {
        //TODO:- v1とはか切り出す。また,roomIDは引数で持ってくる。このroomIDはデバック用whereFieldを使って時系列順に取り出す
        let roomID = "gjqF2hDA0SAV8sad15jU"
        self.listener = self.firestore.collection("message/v1/rooms/").document(roomID).collection("transcripts").order(by: "createdAt", descending: false).addSnapshotListener { [weak self] (documentSnapshot, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let documents = documentSnapshot?.documents else {
                print("The document doesn't exist.")
                return
            }
            
            let transcripts = documents.compactMap { queryDocumentSnapshot -> Transcript? in
                return try? queryDocumentSnapshot.data(as: Transcript.self)
            }
            
            self?.presenter.successFetchTransScript(transScripts: transcripts)
        }
    }
    
    func sendMessage(messageText: String) {
        let transcript = Transcript(from: "fox", to: "bob", text: messageText)
        //TODO:- v1とはか切り出す。また,roomIDは引数で持ってくる。このroomIDはデバック用whereFieldを使って時系列順に取り出す
        let roomID = "gjqF2hDA0SAV8sad15jU"
        do {
            _ = try self.firestore.collection("message/v1/rooms/").document(roomID).collection("transcripts").addDocument(from: transcript) { [weak self] error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                self?.presenter.successSendMessage()
            }
            
        } catch let error {
            print("Error: \(error.localizedDescription)")
            return
        }
    }
}
