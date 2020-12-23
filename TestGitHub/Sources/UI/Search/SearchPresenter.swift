//
//  SearchPresenter.swift
//  TestGitHub
//
//  Created by Olga Vorona on 23.12.2020.
//

import Foundation

final class SearchPresenter {
    
    private lazy var searchService: SearchServiceProtocol = {
        return SearchService()
    }()
    
    private var viewModels: [RepoModel] = []
    weak var view: SearchViewInput?
    
    private func model(from entity: SearchEntity) -> RepoModel {
        var dateString: String?
        if let date = CachedDateFormatter.date(from: entity.createdAt, of: .serverFull) {
            dateString = CachedDateFormatter.formatDate(date, with: .standard)
            
        }
        return RepoModel(title: "\(entity.owner.login ?? "") \\ \(entity.name)",
                         description: entity.desc,
                         stars: "\(entity.stars)",
                         createDate: dateString != nil ? "Created: \(dateString!)" : "")
    }
}

extension SearchPresenter: SearchViewOutput {
    
    func search(query: String) {
        searchService.search(query: query, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let entity):
                let models = entity.items.map { self.model(from: $0)}
                self.view?.update(with: models)
            case .failure:
                break;
            }
        })
    }
}
