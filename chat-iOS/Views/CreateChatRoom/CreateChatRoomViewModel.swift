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
}

protocol CreateChatRoomModelOutput {
    func successRemoveSelectedUser(updatedSelectedUsersArray: [User])
    func successAppendUser(updatedSelectedUsersArray: [User])
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
}
