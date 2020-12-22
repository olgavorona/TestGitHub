//
//  URLComponents+Extensions.swift
//  TestGitHub
//
//  Created by Olga Vorona on 22.12.2020.
//

import Foundation

extension URLComponents {
    
    mutating
    func add(queryItem: URLQueryItem, replaceExisting: Bool = true) {
        guard let items = queryItems else {
            queryItems = [queryItem]
            return
        }
        guard !replaceExisting else {
            queryItems = items
                .filter { $0.name != queryItem.name }
            return
        }
        
        guard !items.contains(where: { $0.name == queryItem.name }) else {
            return
        }
        queryItems?.append(queryItem)
    }
    
}
