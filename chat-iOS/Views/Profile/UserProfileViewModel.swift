//
//  UserProfileModel.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/06/22.
//


protocol UserProfileViewModelProtocol {
    var presenter: UserProfileViewModelOutput! { get set }
}

protocol UserProfileViewModelOutput {
    
}

final class UserProfileViewModel: UserProfileViewModelProtocol {
    var presenter: UserProfileViewModelOutput!
}
