//
//  ChatsViewModel.swift
//  chat-iOS
//
//  Created by jun on 2020/06/22.
//

import Firebase

protocol ChatsViewModelProtocol {
    var presenter: ChatsViewModelOutput! { get set }
    var firestore: Firestore! { get }
    
    func setUpFirestore()
    func fetchTransScript()
    
    func sendMessage(messageText: String)
}

protocol ChatsViewModelOutput {
    func successFetchTransScript(transScripts: [Transcript])
}

final class ChatsViewModel: ChatsViewModelProtocol {
    var presenter: ChatsViewModelOutput!
    internal var firestore: Firestore!
    
    init() {
        self.setUpFirestore()
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
        self.firestore.collection("message/v1/rooms/").document(roomID).collection("transcripts").getDocuments { (documentSnapshot, error) in
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
        
    }
}
