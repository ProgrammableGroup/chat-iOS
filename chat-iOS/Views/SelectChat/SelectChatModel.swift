//
//  SelectChatModel.swift
//  chat-iOS
//
//  Created by 松木周 on 2020/06/21.
//

protocol SelectChatModelProtocol {
    var presenter: SelectChatModelOutput! { get set }
}

protocol SelectChatModelOutput {

}

final class SelectChatModel: SelectChatModelProtocol {
    var presenter: SelectChatModelOutput!
}
