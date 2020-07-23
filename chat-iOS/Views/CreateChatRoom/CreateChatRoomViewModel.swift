//
//  CreateChatRoomViewModel.swift
//  chat-iOS
//
//  Created by jun on 2020/07/18.
//

import Firebase

protocol CreateChatRoomModelProtocol {
    var presenter: CreateChatRoomModelOutput! { get set }
    var selectedUsersArray: [User] { get set }
    var searchedUsersArray: [User] { get set }
    
    func isContaintsUser(user: User) -> Bool
    func searchUser(searchText: String)
    func removeSelectedUserFromSelectedUserArray(user: User)
    func appendUserToSelectedUserArray(user: User)
    func removeSelectedUsersArray(index: Int) -> [User]
    func createChatRoom()
}

protocol CreateChatRoomModelOutput: class {
    func successRemoveSelectedUser()
    func successAppendUser()
    
    func successCreateChatRoom()
    
    func successSearchUser()
}

final class CreateChatRoomModel: CreateChatRoomModelProtocol {
    weak var presenter: CreateChatRoomModelOutput!
    private var firestore: Firestore!
    var selectedUsersArray: [User] = Array()
    var searchedUsersArray: [User] = Array()
    
    init() {
        self.firestore = Firestore.firestore()
        let settings = FirestoreSettings()
        self.firestore.settings = settings
    }
    
    /// ユーザをFirestoreから検索する関数
    /// - Parameter searchText: 検索するユーザ名
    func searchUser(searchText: String) {
        self.firestore.collection("message/v1/users").whereField("displayName", isEqualTo: searchText).getDocuments { [weak self] (documentSnapshot, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let documents = documentSnapshot?.documents else {
                print("The document doesn't exist.")
                return
            }
            
            let searchedUsers = documents.compactMap { queryDocumentSnapshot -> User? in
                return try? queryDocumentSnapshot.data(as: User.self)
            }
            
            self?.searchedUsersArray = searchedUsers
            self?.presenter.successSearchUser()
        }
    }
    
    /// ユーザが既に選択されているかを返す
    /// - Parameter user: 検索するユーザ
    /// - Returns: 検索結果
    func isContaintsUser(user: User) -> Bool {
        if self.selectedUsersArray.filter({ $0.id == user.id ?? "" }).isEmpty { return false }
        return true
    }
    
    func removeSelectedUserFromSelectedUserArray(user: User) {
        self.selectedUsersArray = self.selectedUsersArray.filter({ $0.id != user.id })
        
        self.presenter.successRemoveSelectedUser()
    }
    
    func appendUserToSelectedUserArray(user: User) {
        self.selectedUsersArray.append(user)
        self.presenter.successAppendUser()
    }
    
    /// `selectedUsersArray`からあるインデックスを削除する
    /// - Parameter index: 削除する配列番号
    /// - Returns: 削除した後の`selectedUsersArray`
    func removeSelectedUsersArray(index: Int) -> [User] {
        self.selectedUsersArray.remove(at: index)
        return self.selectedUsersArray
    }
    
    func createChatRoom() {
        //TODO:- 以下2行は自分自身の情報にする。Auth()から取得する。
        let uid = "J5AH7imn7esru3RKZPu6"
        let name = "Bob"
        let memberIDs = [uid] + self.selectedUsersArray.compactMap { $0.id }
        let roomName = name + self.selectedUsersArray.compactMap { $0.displayName }.joined(separator: ",")
        
        //TODO:- `thumbnailImageURL`を決めること
        let room = Room(name: roomName, thumbnailImageURL: nil, members: memberIDs, message: "")
        let roomData: [String: Any]
        
        let roomReference = self.firestore.collection("message").document("v1").collection("rooms").document()
        let batch = self.firestore.batch()
        
        do {
            roomData = try Firestore.Encoder().encode(room)
        } catch let error {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        batch.setData(roomData, forDocument: roomReference)
        
        room.members.forEach { memberID in
            batch.setData([:], forDocument: roomReference.collection("members").document(memberID))
        }
        
        batch.commit { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            self.presenter.successCreateChatRoom()
        }
    }
}
