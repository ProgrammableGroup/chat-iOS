//
//  SelectChatViewPresenter.swift
//  chat-iOS
//
//  Created by 松木周 on 2020/07/15.
//

import Foundation

protocol SelectChatViewPresenterProtocol {
    var view: SelectChatViewPresenterOutput! { get set }
    var currentChatRooms: [Room] { get }
    func didLoadViewController()
    func didTapTableViewCell(selectedRoom room: Room)
}

protocol SelectChatViewPresenterOutput: class {
    func setCurrentChatUsers()
    func showAlert(withMessage message: String)
    func transitionToChatsViewController(selectedRoom room: Room)
}

final class SelectChatViewPresenter: SelectChatViewPresenterProtocol, SelectChatModelOutput {

    weak var view: SelectChatViewPresenterOutput!
    private var model: SelectChatModelProtocol

    private(set) var _currentChatRooms: [Room] = []

    init(model: SelectChatModelProtocol) {
        self.model = model
        self.model.presenter = self
    }

    var currentChatRooms: [Room] {
        return _currentChatRooms
    }

    func didLoadViewController() {
        self.model.fetchCurrentChatRoom()
    }

    func successFetchCurrentChatRooms(currentChatRooms rooms: [Room]) {
        self._currentChatRooms = rooms
        self.view.setCurrentChatUsers()
    }

    func onError(error: Error?) {
        DispatchQueue.main.async { [weak self] in
            let message = error?.localizedDescription ?? "チャット相手を取得できませんでした"
            self?.view.showAlert(withMessage: message)
        }
    }

    func didTapTableViewCell(selectedRoom room: Room) {
        DispatchQueue.main.async { [weak self] in
            self?.view.transitionToChatsViewController(selectedRoom : room)
        }
    }

}
