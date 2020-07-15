//
//  SelectChatModel.swift
//  chat-iOS
//
//  Created by 松木周 on 2020/07/15.
//

import Foundation

protocol SelectChatModelProtocol {
    var presenter: SelectChatModelOutput! { get set }
}

protocol SelectChatModelOutput: class {
}

final class SelectChatModel: SelectChatModelProtocol {

    weak var presenter: SelectChatModelOutput!
}
