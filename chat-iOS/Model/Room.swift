//
//  Room.swift
//  chat-iOS
//
//  Created by 戸高新也 on 2020/07/04.
//

struct Room: Codable {
    let name: String?
    let thumbnailImageURL: String?
    let members: [String]
    let message: String
}
