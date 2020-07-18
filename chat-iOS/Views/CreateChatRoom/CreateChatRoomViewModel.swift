//
//  CreateChatRoomViewModel.swift
//  chat-iOS
//
//  Created by jun on 2020/07/18.
//

protocol CreateChatRoomModelProtocol {
    var presenter: CreateChatRoomModelOutput! { get set }
    
    func isContaintsUser(user: User) -> Bool
    func searchUser(searchText: String)
    func removeSelectedUserFromSelectedUserArray(user: User)
    func appendUserToSelectedUserArray(user: User)
    func removeSelectedUsersArray(index: Int) -> [User]
    func createChatRoom(roomUser: [User])
}

protocol CreateChatRoomModelOutput {
    func successRemoveSelectedUser(updatedSelectedUsersArray: [User])
    func successAppendUser(updatedSelectedUsersArray: [User])
    
    func successCreateChatRoom()
    
    func successSearchUser(searchedUsers: [User])
}

final class CreateChatRoomModel: CreateChatRoomModelProtocol {
    var presenter: CreateChatRoomModelOutput!
    private var selectedUsersArray: [User] = Array()
    
    //TODO:- firestoreから検索すること
    func searchUser(searchText: String) {
        self.presenter.successSearchUser(searchedUsers: [User(id: "234", displayName: "Ox", profileImageURL: "http")])
    }
    
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
    
    func removeSelectedUsersArray(index: Int) -> [User] {
        self.selectedUsersArray.remove(at: index)
        return self.selectedUsersArray
    }
    
    //TODO:- Firesotreに保存する
    func createChatRoom(roomUser: [User]) {
        self.presenter.successCreateChatRoom()
    }
}
