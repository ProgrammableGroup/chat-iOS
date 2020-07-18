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
}

protocol CreateChatRoomViewPresenterOutput {
    func reloadSerchUserTableview_updateSelectedUsersArray(updatedSelectedUsersArray: [User])
    func reloadSelectedUserCollectionView_updateSelectedUsersArray(updatedSelectedUsersArray: [User])
    func hiddenSelectedUsersCollectionView()
}

final class CreateChatRoomViewPresenter: CreateChatRoomViewPresenterProtocol, CreateChatRoomModelOutput {
    var view: CreateChatRoomViewPresenterOutput!
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
        self.view.reloadSerchUserTableview_updateSelectedUsersArray(updatedSelectedUsersArray: updatedSelectedUsersArray)
        self.view.reloadSelectedUserCollectionView_updateSelectedUsersArray(updatedSelectedUsersArray: updatedSelectedUsersArray)
        if updatedSelectedUsersArray.isEmpty { self.view.hiddenSelectedUsersCollectionView()}
    }
    
    func successRemoveSelectedUser(updatedSelectedUsersArray: [User]) {
        self.view.reloadSerchUserTableview_updateSelectedUsersArray(updatedSelectedUsersArray: updatedSelectedUsersArray)
        self.view.reloadSelectedUserCollectionView_updateSelectedUsersArray(updatedSelectedUsersArray: updatedSelectedUsersArray)
        if updatedSelectedUsersArray.isEmpty { self.view.hiddenSelectedUsersCollectionView()}
    }
    
    func successAppendUser(updatedSelectedUsersArray: [User]) {
        self.view.reloadSerchUserTableview_updateSelectedUsersArray(updatedSelectedUsersArray: updatedSelectedUsersArray)
        self.view.reloadSelectedUserCollectionView_updateSelectedUsersArray(updatedSelectedUsersArray: updatedSelectedUsersArray)
    }
}
