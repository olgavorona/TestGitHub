//
//  AuthorEntity.swift
//  TestGitHub
//
//  Created by Olga Vorona on 22.12.2020.
//

import Foundation

struct AuthorEntity: Codable {
    let login: String?
    let avatar: String?
}

extension AuthorEntity {
    enum CodingKeys: String, CodingKey {
        case avatar = "avatar_url"
        case login
    }
}
