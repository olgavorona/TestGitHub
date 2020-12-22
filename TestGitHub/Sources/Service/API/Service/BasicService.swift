//
//  BasicService.swift
//  TestGitHub
//
//  Created by Olga Vorona on 22.12.2020.
//

import Foundation

enum ServiceURL: String {
    case search = "https://api.github.com/search/repositories"
    case trending = "https://ghapi.huchen.dev/repositories"
}

class BasicService {
    var session: URLSession {
        return URLSession.shared
    }
    
}

