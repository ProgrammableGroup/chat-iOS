//
//  File.swift
//  chat-iOS
//
//  Created by jun on 2020/07/18.
//

import UIKit

final class CreateChatRoomViewController: UIViewController {
    private var presenter: CreateChatRoomViewPresenterProtocol!
    
    @IBOutlet weak var userNameSearchBar: UISearchBar!
    @IBOutlet weak var serchUserTableview: UITableView!
    @IBOutlet weak var selectedUserCollectionView: UICollectionView!
    
    var searchedUsers: [User] = [User(id: "1212", displayName: "Bob", profileImageURL: "http..."), User(id: "1212", displayName: "Joe", profileImageURL: "http...")]
    var selectedUsers: [User] = Array()
    
    private let searchedUsersCellID = "SearchUserTableviewCell"
    private let selectedUsersCellID = "SelectedUserCollectionViewCell"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUserSearchBar()
        self.setupSerchUserTableview()
        self.setupSelectedUserCollectionView()
    }
    
    private func setupUserSearchBar() {
        self.userNameSearchBar.placeholder = "Search by name"
        self.userNameSearchBar.delegate = self
    }
    
    private func setupSerchUserTableview() {
        self.serchUserTableview.rowHeight = 75
        self.serchUserTableview.delegate = self
        self.serchUserTableview.dataSource = self
        self.serchUserTableview.tableFooterView = UIView()
    }
    
    private func setupSelectedUserCollectionView() {
        self.selectedUserCollectionView.isHidden = true
    }
    
    func inject(with presenter: CreateChatRoomViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension CreateChatRoomViewController: CreateChatRoomViewPresenterOutput {
    
}

extension CreateChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.searchedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.serchUserTableview.dequeueReusableCell(withIdentifier: self.searchedUsersCellID, for: indexPath)
                         as? SearchUserTableviewCell else { return UITableViewCell() }
        
        cell.userNameLabel.text = self.searchedUsers[indexPath.item].displayName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.serchUserTableview.deselectRow(at: indexPath, animated: true)
    }
  
}

extension CreateChatRoomViewController: UISearchBarDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard self.userNameSearchBar.isFirstResponder else { return }
        self.userNameSearchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        guard self.userNameSearchBar.isFirstResponder else { return }
        self.userNameSearchBar.resignFirstResponder()
        
        print("searchText = \(searchBarText)")
    }
}
