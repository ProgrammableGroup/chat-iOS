//
//  ChatsViewPresenter.swift
//  chat-iOS
//
//  Created by jun on 2020/06/22.
//

protocol ChatsViewPresenterProtocol {
    var view: ChatsViewPresenterOutput! { get set }
}

protocol ChatsViewPresenterOutput {
    
}

final class ChatsViewPresenter: ChatsViewPresenterProtocol, ChatsViewModelOutput {
    var view: ChatsViewPresenterOutput!
    private var model: ChatsViewModelProtocol
    
    init(model: ChatsViewModelProtocol) {
        self.model = model
    }
}
