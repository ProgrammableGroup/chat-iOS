//
//  SelectChatViewPresenter.swift
//  chat-iOS
//
//  Created by 松木周 on 2020/06/21.
//

protocol SelectChatViewPresenterProtocol {
    var view: SelectChatViewPresenterOutput! { get set }
}

protocol SelectChatViewPresenterOutput {

}

final class SelectChatViewPresenter: SelectChatViewPresenterProtocol, SelectChatModelOutput {
    var view: SelectChatViewPresenterOutput!
    private var model: SelectChatModelProtocol

    init(model: SelectChatModelProtocol) {
        self.model = model
    }
}
