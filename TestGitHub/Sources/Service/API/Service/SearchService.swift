//
//  SearchService.swift
//  TestGitHub
//
//  Created by Olga Vorona on 22.12.2020.
//

import Foundation

final class SearchService: BasicService, SearchServiceProtocol {
    
    private enum QueryItemName: String {
        case query = "q"
        case count = "per_page"
    }
    func search(query: String, completion: @escaping (Result<SearchEntities,Error>) -> Void) {
        var components = URLComponents(string: ServiceURL.search.rawValue)
        components?.add(queryItem: URLQueryItem(name: QueryItemName.query.rawValue, value: query))
        components?.add(queryItem: URLQueryItem(name: QueryItemName.count.rawValue, value: "100"))

        guard let url = components?.url else {
            completion(.failure(ServiceError.buildingRequest))
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
                result = .failure(ServiceError.request(error))
                return
            }

            do {
                let responseObject = try JSONDecoder().decode(SearchEntities.self, from: data)
                result = .success(responseObject)
            } catch {
                result = .failure(ServiceError.decoding(error))
            }
        }.resume()
    }

}
