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

protocol ChatsViewPresenterOutput {
    func updateChatsCollectionView(transScripts: [Transcript])
    func removeTextOfInputTextView()
}

final class ChatsViewPresenter: ChatsViewPresenterProtocol, ChatsViewModelOutput {
    var view: ChatsViewPresenterOutput!
    private var model: ChatsViewModelProtocol
    
    init(model: ChatsViewModelProtocol) {
        self.model = model
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
