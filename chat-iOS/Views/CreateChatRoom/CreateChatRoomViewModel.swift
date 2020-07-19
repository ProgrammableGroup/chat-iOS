//
//  CreateChatRoomViewModel.swift
//  chat-iOS
//
//  Created by jun on 2020/07/18.
//

import Firebase

protocol CreateChatRoomModelProtocol {
    var presenter: CreateChatRoomModelOutput! { get set }
    
    func isContaintsUser(user: User) -> Bool
    func searchUser(searchText: String)
    func removeSelectedUserFromSelectedUserArray(user: User)
    func appendUserToSelectedUserArray(user: User)
    func removeSelectedUsersArray(index: Int) -> [User]
    func createChatRoom(roomUser: [User])
}

protocol CreateChatRoomModelOutput: class {
    func successRemoveSelectedUser(updatedSelectedUsersArray: [User])
    func successAppendUser(updatedSelectedUsersArray: [User])
    
    func successCreateChatRoom()
    
    func successSearchUser(searchedUsers: [User])
}

final class CreateChatRoomModel: CreateChatRoomModelProtocol {
    weak var presenter: CreateChatRoomModelOutput!
    private var firestore: Firestore!
    private var selectedUsersArray: [User] = Array()
    
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
            
            self?.presenter.successSearchUser(searchedUsers: searchedUsers)
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
        
        self.presenter.successRemoveSelectedUser(updatedSelectedUsersArray: self.selectedUsersArray)
    }
    
    func appendUserToSelectedUserArray(user: User) {
        self.selectedUsersArray.append(user)
        
        self.presenter.successAppendUser(updatedSelectedUsersArray: self.selectedUsersArray)
    }
    
    /// `selectedUsersArray`からあるインデックスを削除する
    /// - Parameter index: 削除する配列番号
    /// - Returns: 削除した後の`selectedUsersArray`
    func removeSelectedUsersArray(index: Int) -> [User] {
        self.selectedUsersArray.remove(at: index)
        return self.selectedUsersArray
    }
    
    //TODO:- Firesotreに保存する
    func createChatRoom(roomUser: [User]) {
        self.presenter.successCreateChatRoom()
    }
}
