//
//  RecommendationEntity.swift
//  TestGitHub
//
//  Created by Olga Vorona on 22.12.2020.
//

import Foundation

struct TrendingEntities: Codable {
    let items: [TrendingEntity]
}

struct TrendingEntity: Codable {
    let repo: String
    let stars: String
    let currentPeriodStars: String
    let desc: String
    let url: String
}

extension TrendingEntity {
    enum CodingKeys: String, CodingKey {
        case currentPeriodStars = "added_stars"
        case url = "repo_link"
        case repo,stars,desc
    }
}
