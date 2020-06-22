//
//  ChatsViewModel.swift
//  chat-iOS
//
//  Created by jun on 2020/06/22.
//

protocol ChatsViewModelProtocol {
    var presenter: ChatsViewModelOutput! { get set }
}

protocol ChatsViewModelOutput {
    
}

final class ChatsViewModel: ChatsViewModelProtocol {
    var presenter: ChatsViewModelOutput!
}
