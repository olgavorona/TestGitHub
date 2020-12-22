//
//  SearchServiceProtocol.swift
//  TestGitHub
//
//  Created by Olga Vorona on 22.12.2020.
//

import Foundation

protocol SearchServiceProtocol {
    func search(query: String, completion: @escaping (Result<SearchEntities,Error>) -> Void)
}
