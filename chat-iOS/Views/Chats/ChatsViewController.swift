//
//  ChatsViewController.swift
//  chat-iOS
//
//  Created by jun on 2020/06/22.
//

import UIKit

final class ChatsViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    private var presenter: ChatsViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func inject(with presenter: ChatsViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension ChatsViewController: ChatsViewPresenterOutput {
    
}
