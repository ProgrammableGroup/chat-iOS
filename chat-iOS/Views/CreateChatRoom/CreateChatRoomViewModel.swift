//
//  CreateChatRoomViewModel.swift
//  chat-iOS
//
//  Created by jun on 2020/07/18.
//

protocol CreateChatRoomModelProtocol {
    var presenter: CreateChatRoomModelOutput! { get set }
}

protocol CreateChatRoomModelOutput {
    
}

final class CreateChatRoomModel: CreateChatRoomModelProtocol {
    var presenter: CreateChatRoomModelOutput!
}
