//
//  CreateChatRoomViewPresenter.swift
//  chat-iOS
//
//  Created by jun on 2020/07/18.
//

protocol CreateChatRoomViewPresenterProtocol {
    var view: CreateChatRoomViewPresenterOutput! { get set }
    
    func didSelectedSerchUserTableview(selectedUser: User)
    func didTapSelectedUserCollectionViewCellDeleteUserButton(index: Int)
    
    func didTapStopCreateRoomButton()
    func didTapCreateRoomutton(selectedUsersArray: [User])
    
    func didSearchBarSearchButtonClicked(searchText: String)
}

protocol CreateChatRoomViewPresenterOutput: class {
    func reloadSerchUserTableview(updatedSearchedUsersArray: [User])
    func reloadSerchUserTableview()
    func reloadSelectedUserCollectionView(updatedSelectedUsersArray: [User])
    
    func hiddenSelectedUsersCollectionView()
    func dismissCreateChatRoomVC()
    func clearSearchUserTableView()
    
    func startActivityIndicator()
    func stopActivityIndicator()
}

final class CreateChatRoomViewPresenter: CreateChatRoomViewPresenterProtocol, CreateChatRoomModelOutput {
    weak var view: CreateChatRoomViewPresenterOutput!
    private var model: CreateChatRoomModelProtocol
    
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
        
        self.view.reloadSelectedUserCollectionView(updatedSelectedUsersArray: updatedSelectedUsersArray)
        self.view.reloadSerchUserTableview()
        if updatedSelectedUsersArray.isEmpty { self.view.hiddenSelectedUsersCollectionView()}
    }
    
    func didTapStopCreateRoomButton() {
        self.view.dismissCreateChatRoomVC()
    }
    
    func didTapCreateRoomutton(selectedUsersArray: [User]) {
        guard !selectedUsersArray.isEmpty else { return }
        
        self.model.createChatRoom(roomUser: selectedUsersArray)
    }
    
    func didSearchBarSearchButtonClicked(searchText: String) {
        self.view.clearSearchUserTableView()
        self.view.startActivityIndicator()
        self.model.searchUser(searchText: searchText)
    }
    
    func successSearchUser(searchedUsers: [User]) {
        self.view.reloadSerchUserTableview(updatedSearchedUsersArray: searchedUsers)
        self.view.stopActivityIndicator()
    }
    
    func successRemoveSelectedUser(updatedSelectedUsersArray: [User]) {
        self.view.reloadSelectedUserCollectionView(updatedSelectedUsersArray: updatedSelectedUsersArray)
        self.view.reloadSerchUserTableview()
        if updatedSelectedUsersArray.isEmpty { self.view.hiddenSelectedUsersCollectionView()}
    }
    
    func successAppendUser(updatedSelectedUsersArray: [User]) {
        self.view.reloadSelectedUserCollectionView(updatedSelectedUsersArray: updatedSelectedUsersArray)
        self.view.reloadSerchUserTableview()
    }
    
    func successCreateChatRoom() {
        self.view.dismissCreateChatRoomVC()
    }
}
