//
//  Room.swift
//  chat-iOS
//
//  Created by 戸高新也 on 2020/07/04.
//
import Firebase

struct Room: Codable {
    let name: String?
    let thumbnailImageURL: String?
    let members: [String]
    let message: String
    @DocumentID var id: String? 
    @ServerTimestamp var updateAt: Timestamp?
}
