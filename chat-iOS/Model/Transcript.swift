//
//  Transcript.swift
//  chat-iOS
//
//  Created by 戸高新也 on 2020/07/04.
//

import Firebase

struct Transcript: Codable {
    let from: String
    let to: String
    let text: String?
    @ServerTimestamp var createdAt: Timestamp?
}
