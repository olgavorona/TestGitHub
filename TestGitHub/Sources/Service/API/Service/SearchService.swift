//
//  SearchService.swift
//  TestGitHub
//
//  Created by Olga Vorona on 22.12.2020.
//

import Foundation

enum SearchServiceError: Error {
    case missingSettings
    case buildingRequest
    case request(Error?)
    case decoding(Error)
}

final class SearchService: BasicService, SearchServiceProtocol {
    
    private enum QueryItemName: String {
        case query = "q"
    }
    func search(query: String, completion: @escaping (Result<SearchEntities,Error>) -> Void) {
        var components = URLComponents(string: ServiceURL.search.rawValue)
        components?.add(queryItem: URLQueryItem(name: QueryItemName.query.rawValue, value: query))
        guard let url = components?.url else {
            completion(.failure(SearchServiceError.buildingRequest))
            return
        }

        session.dataTask(with: url) { (data, response, error) in
            let result: Result<SearchEntities, Error>
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  (200 ..< 300) ~= response.statusCode,
                  error == nil else {
                result = .failure(SearchServiceError.request(error))
                return
            }

            do {
                let responseObject = try JSONDecoder().decode(SearchEntities.self, from: data)
                result = .success(responseObject)
            } catch {
                result = .failure(SearchServiceError.decoding(error))
            }
        }.resume()
    }

}
