//
//  CreateChatRoomViewModel.swift
//  chat-iOS
//
//  Created by jun on 2020/07/18.
//

protocol CreateChatRoomModelProtocol {
    var presenter: CreateChatRoomModelOutput! { get set }
    
    func isContaintsUser(user: User) -> Bool
    func removeSelectedUserFromSelectedUserArray(user: User)
    func appendUserToSelectedUserArray(user: User)
    func removeSelectedUsersArray(index: Int) -> [User]
    func createChatRoom(roomUser: [User])
}

protocol CreateChatRoomModelOutput {
    func successRemoveSelectedUser(updatedSelectedUsersArray: [User])
    func successAppendUser(updatedSelectedUsersArray: [User])
    
    func successCreateChatRoom()
}

final class CreateChatRoomModel: CreateChatRoomModelProtocol {
    var presenter: CreateChatRoomModelOutput!
    private var selectedUsersArray: [User] = Array()
    
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
