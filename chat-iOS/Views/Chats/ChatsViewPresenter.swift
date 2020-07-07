//
//  ChatsViewPresenter.swift
//  chat-iOS
//
//  Created by jun on 2020/06/22.
//

protocol ChatsViewPresenterProtocol {
    var view: ChatsViewPresenterOutput! { get set }
    
    func didLoadViewController()
}

protocol ChatsViewPresenterOutput {
    func updateChatsCollectionView(transScripts: [Transcript])
}

final class ChatsViewPresenter: ChatsViewPresenterProtocol, ChatsViewModelOutput {
    var view: ChatsViewPresenterOutput!
    private var model: ChatsViewModelProtocol
    
    init(model: ChatsViewModelProtocol) {
        self.model = model
        self.model.presenter = self
        
        self.model.setUpFirestore()
    }
    
    func didLoadViewController() {
        self.model.fetchTransScript()
    }
    
    func successFetchTransScript(transScripts: [Transcript]) {
        self.view.updateChatsCollectionView(transScripts: transScripts)
    }
}
