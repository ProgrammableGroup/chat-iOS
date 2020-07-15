//
//  SelectChatViewPresenter.swift
//  chat-iOS
//
//  Created by 松木周 on 2020/07/15.
//

import Foundation

protocol SelectChatViewPresenterProtocol {
    var view: SelectChatViewPresenterOutput! { get set }
}

protocol SelectChatViewPresenterOutput: class {
}

final class SelectChatViewPresenter: SelectChatViewPresenterProtocol, SelectChatModelOutput {

    weak var view: SelectChatViewPresenterOutput!
    private var model: SelectChatModelProtocol

    init(model: SelectChatModelProtocol) {
        self.model = model
    }

}
