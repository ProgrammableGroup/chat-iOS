//
//  SelectChatViewController.swift
//  chat-iOS
//
//  Created by 松木周 on 2020/06/21.
//

import UIKit

final class SelectChatViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let reuseCellId = "SelectChatTableViewCell"
    private var users = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }


    private func setup() {

        tableView.register(UINib(nibName: "SelectChatTableViewCell", bundle: nil), forCellReuseIdentifier: reuseCellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

    }

}

extension SelectChatViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellId) as! SelectChatTableViewCell

        return cell
    }

}
