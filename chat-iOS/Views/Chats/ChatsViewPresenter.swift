//
//  ChatsViewPresenter.swift
//  chat-iOS
//
//  Created by jun on 2020/06/22.
//

protocol ChatsViewPresenterProtocol {
    var view: ChatsViewPresenterOutput! { get set }
    
    func didLoadViewController()
    func didTapSendButton(messageText: String)
}

protocol ChatsViewPresenterOutput: class {
    func updateChatsCollectionView(transScripts: [Transcript])
    func removeTextOfInputTextView()
}

final class ChatsViewPresenter: ChatsViewPresenterProtocol, ChatsViewModelOutput {
    weak var view: ChatsViewPresenterOutput!
    private var model: ChatsViewModelProtocol
    private var roomId: String
    private var roomName: String
    
    init(model: ChatsViewModelProtocol, withRoomId roomId: String, withRoomName roomName: String) {
        self.model = model
        self.roomId = roomId
        self.roomName = roomName
        self.model.presenter = self
    }
    
    func didLoadViewController() {
        self.model.fetchTransScript()
    }
    
    func successFetchTransScript(transScripts: [Transcript]) {
        self.view.updateChatsCollectionView(transScripts: transScripts)
    }
    
    func didTapSendButton(messageText: String) {
        self.model.sendMessage(messageText: messageText)
    }
    
    func successSendMessage() {
        self.view.removeTextOfInputTextView()
    }
}
