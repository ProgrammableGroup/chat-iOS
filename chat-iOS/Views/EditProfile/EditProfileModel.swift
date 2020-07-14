//
//  EditProfileModel.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/07/03.
//

protocol EditProfileModelProtocol {
    var presenter: EditProfileModelOutput! { get set }
    func saveProfile()
}

protocol EditProfileModelOutput {
    
}

final class EditProfileModel: EditProfileModelProtocol {
    var presenter: EditProfileModelOutput!
    
    func saveProfile() {
        
    }
}

