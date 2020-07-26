//
//  EditProfilePresenter.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/07/03.
//

protocol EditProfileViewPresenterProtocol {
    var view: EditProfileViewPresenterOutput! { get set }
    func didTapStopEditProfileButton()
    func didTapSaveEditProfileButton()
    func didTapChangePhotoButton()
    func didTapPickupPhotoAction()
    func didTapTakePhotoAction()
}

protocol EditProfileViewPresenterOutput {
    func dismissEditProfileViewController()
    func showActionSheet()
    func showImagePickerControllerAsPhotoLibrary()
    func showImagePickerControllerAsCamera()
}

final class EditProfileViewPresenter: EditProfileViewPresenterProtocol, EditProfileModelOutput {
    
    var view: EditProfileViewPresenterOutput!
    private var model: EditProfileModelProtocol

    init(model: EditProfileModelProtocol) {
        self.model = model
    }
    
    func didTapStopEditProfileButton() {
        view.dismissEditProfileViewController()
    }
    
    func didTapSaveEditProfileButton() {
        self.model.saveProfile()
        
    }
    func didTapChangePhotoButton() {
        view.showActionSheet()
    }
    
    func didTapPickupPhotoAction() {
        view.showImagePickerControllerAsPhotoLibrary()
    }
    
    func didTapTakePhotoAction() {
        view.showImagePickerControllerAsCamera()
    }

}
