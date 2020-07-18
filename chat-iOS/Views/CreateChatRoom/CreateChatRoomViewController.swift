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
    
    @IBOutlet weak var selectedUserCollectionViewBottomsConstraints: NSLayoutConstraint!
    
    var searchedUsersArray: [User] = [User(id: "1212", displayName: "Bob", profileImageURL: "http..."), User(id: "1324", displayName: "Joe", profileImageURL: "http...")]
    var selectedUsersArray: [User] = Array()
    
    private let searchedUsersCellID = "SearchUserTableviewCell"
    private let selectedUsersCellID = "SelectedUserCollectionViewCell"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUserSearchBar()
        self.setupSerchUserTableview()
        self.setupSelectedUserCollectionView()
        self.setupNotificationCenter()
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
        self.selectedUserCollectionView.collectionViewLayout.invalidateLayout()
        self.selectedUserCollectionView.delegate = self
        self.selectedUserCollectionView.dataSource = self
    }
    
    func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShowNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHideNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// キーボードが登場した時の処理
    @objc func keyboardWillShowNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboard = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        print("登場")
        self.selectedUserCollectionViewBottomsConstraints.constant = -keyboard.cgRectValue.height + self.view.safeAreaInsets.bottom
        UIView.animate(withDuration: 1.0, animations: { self.view.layoutIfNeeded() })
    }
    
    /// キーボードが隠れた時の処理
    @objc func keyboardWillHideNotification(notification: NSNotification) {
        guard notification.userInfo != nil else { return }
        print("バイバイ")
        self.selectedUserCollectionViewBottomsConstraints.constant = 0
        UIView.animate(withDuration: 1.0, animations: { self.view.layoutIfNeeded() })
    }
    
    @objc func tapSelectedUserCollectionViewCellDeleteUserButton(_ button: UIButton) {
        self.presenter.didTapSelectedUserCollectionViewCellDeleteUserButton(index: button.tag)
    }
    
    func inject(with presenter: CreateChatRoomViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension CreateChatRoomViewController: CreateChatRoomViewPresenterOutput {
    func reloadSerchUserTableview_updateSelectedUsersArray(updatedSelectedUsersArray: [User]) {
        self.selectedUsersArray = updatedSelectedUsersArray
        
        DispatchQueue.main.async {
            self.serchUserTableview.reloadData()
        }
    }
    func reloadSelectedUserCollectionView_updateSelectedUsersArray(updatedSelectedUsersArray: [User]) {
        self.selectedUsersArray = updatedSelectedUsersArray
        
        DispatchQueue.main.async {
            if self.selectedUserCollectionView.isHidden { self.selectedUserCollectionView.isHidden = false }
            self.selectedUserCollectionView.reloadData()
        }
    }
    func hiddenSelectedUsersCollectionView() {
        DispatchQueue.main.async {
            self.selectedUserCollectionView.isHidden = true
        }
    }
}

extension CreateChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.searchedUsersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.serchUserTableview.dequeueReusableCell(withIdentifier: self.searchedUsersCellID, for: indexPath)
                         as? SearchUserTableviewCell else { return UITableViewCell() }
        
        cell.userNameLabel.text = self.searchedUsersArray[indexPath.item].displayName
        if !self.selectedUsersArray.filter({ $0.id == searchedUsersArray[indexPath.item].id ?? ""}).isEmpty {
            cell.changeFillImageRadioImageView()
        } else {
            cell.changeNotFillImageRadioImageView()
        }
        
        //TODO:Firestoreから取得した後で表示し直すこと
        if #available(iOS 13.0, *) {
            cell.profileImageView.image = UIImage(systemName: "bolt.circle.fill")
        } else {
            // Fallback on earlier versions
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.serchUserTableview.deselectRow(at: indexPath, animated: true)
        self.presenter.didSelectedSerchUserTableview(selectedUser: self.searchedUsersArray[indexPath.item])
    }
  
}

extension CreateChatRoomViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedUsersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: selectedUsersCellID, for: indexPath) as! SelectedUserCollectionViewCell
        
        cell.userNameLabel.text = self.selectedUsersArray[indexPath.item].displayName
        
        cell.deleteUserButton.tag = indexPath.item
        cell.deleteUserButton.addTarget(self, action: #selector(tapSelectedUserCollectionViewCellDeleteUserButton(_:)), for: .touchUpInside)
        
        //TODO:Firestoreから取得した後で表示し直すこと
        if #available(iOS 13.0, *) {
            cell.profileImageView.image = UIImage(systemName: "bolt.circle.fill")
        } else {
            // Fallback on earlier versions
        }
       
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 85, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10)
    }
}

extension CreateChatRoomViewController: UISearchBarDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard scrollView == self.serchUserTableview else { return }
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
