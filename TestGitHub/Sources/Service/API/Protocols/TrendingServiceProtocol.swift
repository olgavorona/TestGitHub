//
//  TrendingServiceProtocol.swift
//  TestGitHub
//
//  Created by Olga Vorona on 23.12.2020.
//

import Foundation

protocol TrendingServiceProtocol {
    func getTrending(type: Int, completion: @escaping (Result<[TrendingEntity],Error>) -> Void)
}
