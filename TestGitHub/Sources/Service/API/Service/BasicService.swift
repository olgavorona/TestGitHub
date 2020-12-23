//
//  BasicService.swift
//  TestGitHub
//
//  Created by Olga Vorona on 22.12.2020.
//

import Foundation

enum ServiceURL: String {
    case search = "https://api.github.com/search/repositories"
    case trending = "https://trendings.herokuapp.com/repo"
}

enum ServiceError: Error {
    case missingSettings
    case buildingRequest
    case request(Error?)
    case decoding(Error)
}

class BasicService {
    var session: URLSession {
        return URLSession.shared
    }
    
}

