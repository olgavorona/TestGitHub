//
//  SearchEntity.swift
//  TestGitHub
//
//  Created by Olga Vorona on 22.12.2020.
//

import Foundation

struct SearchEntities: Codable {
    let items: [SearchEntity]
}

struct SearchEntity: Codable {
    let name: String
    let createdAt: String
    let owner: AuthorEntity
    let stars: Int
    let desc: String?
    let url: String
}

extension SearchEntity {
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case stars = "stargazers_count"
        case desc = "description"
        case url = "html_url"
        case name, owner
    }
}
