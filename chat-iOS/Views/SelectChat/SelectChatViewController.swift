//
//  SelectChatViewController.swift
//  chat-iOS
//
//  Created by 松木周 on 2020/07/15.
//

import UIKit

class SelectChatViewController: UIViewController {

    @IBOutlet weak var selectChatTableView: UITableView!

    private let reuseCellId = "SelectChatTableViewCell"
    private var presenter: SelectChatViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelectChatTableView()
    }

    func inject(with presenter: SelectChatViewPresenterProtocol) {
        
        self.presenter = presenter
        self.presenter.view = self

    }

    func setupSelectChatTableView() {

        self.selectChatTableView.delegate = self
        self.selectChatTableView.dataSource = self
        self.selectChatTableView.register(UINib(nibName: reuseCellId, bundle: nil), forCellReuseIdentifier: reuseCellId)
        self.selectChatTableView.tableFooterView = UIView()

    }

}

extension SelectChatViewController: UITableViewDelegate {
}

extension SelectChatViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellId) as! SelectChatTableViewCell

        return cell
    }

}

extension SelectChatViewController: SelectChatViewPresenterOutput {
    
}
