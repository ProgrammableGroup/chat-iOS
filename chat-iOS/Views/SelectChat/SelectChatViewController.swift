//
//  SelectChatViewController.swift
//  chat-iOS
//
//  Created by 松木周 on 2020/06/21.
//

import UIKit

final class SelectChatViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    typealias cell = SelectChatTableViewCell
    private let cellClassName = NSStringFromClass(cell.self).components(separatedBy: ".").last!
    private var users = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }


    private func setup() {

        tableView.register(UINib(nibName: cellClassName, bundle: nil), forCellReuseIdentifier: cellClassName)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellClassName) as! cell

        return cell
    }

}
