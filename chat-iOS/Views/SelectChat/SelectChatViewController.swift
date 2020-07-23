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
    private var currentChatRooms: [Room] = []
    private var presenter: SelectChatViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelectChatTableView()
        self.presenter.didLoadViewController()
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedRoom = currentChatRooms[indexPath.row]
        self.presenter.didTapTableViewCell(selectedRoom: selectedRoom)
    }

}

extension SelectChatViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentChatRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellId) as! SelectChatTableViewCell
        cell.generateCell(withRoom: currentChatRooms[indexPath.row])
        return cell
    }

}

extension SelectChatViewController: SelectChatViewPresenterOutput {

    func setCurrentChatUsers() {
        self.currentChatRooms = self.presenter.currentChatRooms
        self.selectChatTableView.reloadData()
    }

    func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "エラーが発生しました", message: message, preferredStyle: .alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)

        alert.addAction(defaultAction)
        present(alert, animated: false, completion: nil)
    }

    func transitionToChatsViewController(selectedRoom room: Room) {

        guard let roomId = room.id else { return }
        guard let roomName = room.name else { return }
        let chatsViewController = ChatsViewBuilder.create(withRoomId: roomId, withRoomName: roomName)
        self.navigationController?.pushViewController(chatsViewController, animated: true)

    }
    
}
