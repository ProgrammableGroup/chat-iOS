//
//  File.swift
//  chat-iOS
//
//  Created by jun on 2020/07/18.
//

import UIKit

final class CreateChatRoomViewController: UIViewController {
    private var presenter: CreateChatRoomViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func inject(with presenter: CreateChatRoomViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension CreateChatRoomViewController: CreateChatRoomViewPresenterOutput {
    
}

