//
//  EditProfilePresenter.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/07/03.
//

protocol EditProfileViewPresenterProtocol {
    var view: EditProfileViewPresenterOutput! { get set }
}

protocol EditProfileViewPresenterOutput {
    
}

final class EditProfileViewPresenter: EditProfileViewPresenterProtocol, EditProfileModelOutput {
    var view: EditProfileViewPresenterOutput!
    private var model: EditProfileModelProtocol
    
    init(model: EditProfileModelProtocol) {
        self.model = model
    }
}
