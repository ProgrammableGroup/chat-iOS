//
//  CreateChatRoomViewPresenter.swift
//  chat-iOS
//
//  Created by jun on 2020/07/18.
//

protocol CreateChatRoomViewPresenterProtocol {
    var view: CreateChatRoomViewPresenterOutput! { get set }
    var numberOfSearchedUsers: Int { get }
    var numberOfSelectedUsers: Int { get }
    var searchedUsers: [User] { get }
    var selectedUsers: [User] { get }
    
    func isSelected(user: User) -> Bool
    
    func didSelectedSerchUserTableview(selectedUser: User)
    func didTapSelectedUserCollectionViewCellDeleteUserButton(index: Int)
    
    func didTapStopCreateRoomButton()
    func didTapCreateRoomutton()
    
    func didSearchBarSearchButtonClicked(searchText: String)
}

protocol CreateChatRoomViewPresenterOutput: class {
    func reloadSerchUserTableview()
    func reloadSelectedUserCollectionView()
    
    func hiddenSelectedUsersCollectionView()
    func dismissCreateChatRoomVC()
    func clearSearchUserTableView()
    
    func startActivityIndicator()
    func stopActivityIndicator()
}

final class CreateChatRoomViewPresenter: CreateChatRoomViewPresenterProtocol, CreateChatRoomModelOutput {
    weak var view: CreateChatRoomViewPresenterOutput!
    private var model: CreateChatRoomModelProtocol
    
    var numberOfSearchedUsers: Int {
        return self.model.searchedUsersArray.count
    }
    
    var numberOfSelectedUsers: Int {
        return model.selectedUsersArray.count
    }
    
    var searchedUsers: [User] {
        return model.searchedUsersArray
    }
    
    var selectedUsers: [User] {
        return model.selectedUsersArray
    }
    
    init(model: CreateChatRoomModelProtocol) {
        self.model = model
        self.model.presenter = self
    }
    
    func didSelectedSerchUserTableview(selectedUser: User) {
        if self.model.isContaintsUser(user: selectedUser) {
            self.model.removeSelectedUserFromSelectedUserArray(user: selectedUser)
            return
        }
        self.model.appendUserToSelectedUserArray(user: selectedUser)
    }
    
    func didTapSelectedUserCollectionViewCellDeleteUserButton(index: Int) {
        let updatedSelectedUsersArray = self.model.removeSelectedUsersArray(index: index)
        
        self.view.reloadSelectedUserCollectionView()
        self.view.reloadSerchUserTableview()
        if updatedSelectedUsersArray.isEmpty { self.view.hiddenSelectedUsersCollectionView()}
    }
    
    func didTapStopCreateRoomButton() {
        self.view.dismissCreateChatRoomVC()
    }
    
    func didTapCreateRoomutton() {
        guard !self.selectedUsers.isEmpty else { return }
        self.model.createChatRoom()
    }
    
    func didSearchBarSearchButtonClicked(searchText: String) {
        self.view.clearSearchUserTableView()
        self.view.startActivityIndicator()
        self.model.searchUser(searchText: searchText)
    }
    
    func isSelected(user: User) -> Bool { return self.selectedUsers.firstIndex { user.id == $0.id } != nil }
    
    func successSearchUser() {
        self.view.reloadSerchUserTableview()
        self.view.stopActivityIndicator()
    }
    
    func successRemoveSelectedUser() {
        self.view.reloadSelectedUserCollectionView()
        self.view.reloadSerchUserTableview()
        if self.selectedUsers.isEmpty { self.view.hiddenSelectedUsersCollectionView()}
    }
    
    func successAppendUser() {
        self.view.reloadSelectedUserCollectionView()
        self.view.reloadSerchUserTableview()
    }
    
    func successCreateChatRoom() {
        self.view.dismissCreateChatRoomVC()
    }
}
