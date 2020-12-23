//
//  TrendingService.swift
//  TestGitHub
//
//  Created by Olga Vorona on 22.12.2020.
//

import Foundation

enum TrendingType: Int {
    case daily
    case weekly
    case monthly
    
    var value: String {
        switch self {
        case .daily: return "daily"
        case .weekly: return "weekly"
        case .monthly: return "monthly"
        }
    }
    
}

final class TrendingService: BasicService, TrendingServiceProtocol {
    
    private enum QueryItemName: String {
        case since
        case lang
    }
    
    func getTrending(type: Int, completion: @escaping (Result<[TrendingEntity],Error>) -> Void) {
        var components = URLComponents(string: ServiceURL.trending.rawValue)
        let since = TrendingType(rawValue: type) ?? .daily
        components?.add(queryItem: URLQueryItem(name: QueryItemName.lang.rawValue, value: "swift"))
        components?.add(queryItem: URLQueryItem(name: QueryItemName.since.rawValue, value: since.value))
        guard let url = components?.url else {
            completion(.failure(ServiceError.buildingRequest))
            return
        }

        session.dataTask(with: url) { (data, response, error) in
            let result: Result<[TrendingEntity], Error>
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
                let responseObject = try JSONDecoder().decode(TrendingEntities.self, from: data)
                result = .success(responseObject.items)
            } catch {
                result = .failure(ServiceError.decoding(error))
            }
        }.resume()
    }

}
