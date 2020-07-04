//
//  User.swift
//  chat-iOS
//
//  Created by 戸高新也 on 2020/07/04.
//

struct User {
    @DocumentID var id: String?
    let displayName: String
    let profileImageURL: String?
}
