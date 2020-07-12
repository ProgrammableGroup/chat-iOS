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
        if let listener = self.listener { listener.remove()}
    }
    
    func setUpFirestore() {
        self.firestore = Firestore.firestore()
        let settings = FirestoreSettings()
        self.firestore.settings = settings
    }
    
    /// documentDataをTransScriptにデコードする関数
    /// - Parameter documentData: FirestoreのDocumentData
    /// - Returns: デコードしたやつ
    private func decodeTransScript(documentData: [String: Any]) -> Transcript {
        do {
            return try Firestore.Decoder().decode(Transcript.self, from: documentData)
        } catch {
            fatalError("Error decoding firestore data")
        }
    }
    
    func fetchTransScript() {
        //TODO:- v1とはか切り出す。また,roomIDは引数で持ってくる。このroomIDはデバック用whereFieldを使って時系列順に取り出す
        let roomID = "gjqF2hDA0SAV8sad15jU"
        self.listener = self.firestore.collection("message/v1/rooms/").document(roomID).collection("transcripts").order(by: "createdAt", descending: false).addSnapshotListener { (documentSnapshot, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = documentSnapshot else { return }
                        
            let transcripts = snapshot.documents.reduce([Transcript]()) { (array, document) -> [Transcript] in
                var array = array
                guard document.exists else { return array }
                
                array.append(self.decodeTransScript(documentData: document.data()))
                return array
            }
            
            self.presenter.successFetchTransScript(transScripts: transcripts)
        }
    }
    
    func sendMessage(messageText: String) {
        let transcript = Transcript(from: "fox", to: "bob", text: messageText)
        //TODO:- v1とはか切り出す。また,roomIDは引数で持ってくる。このroomIDはデバック用whereFieldを使って時系列順に取り出す
        let roomID = "gjqF2hDA0SAV8sad15jU"
        do {
            _ = try self.firestore.collection("message/v1/rooms/").document(roomID).collection("transcripts").addDocument(from: transcript) { error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                self.presenter.successSendMessage()
            }
            
        } catch let error {
            print("Error: \(error.localizedDescription)")
            return
        }
    }
}
