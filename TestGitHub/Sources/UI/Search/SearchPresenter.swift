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
}

extension SearchPresenter: SearchViewOutput {
    
    func search(query: String) {
        searchService.search(query: query, completion: { [weak self] result in
            switch result {
            case .success(let entity):
                let models = entity.items.map {RepoModel(name: $0.name,
                                                         description: $0.desc,
                                                         stars: $0.stars,
                                                         author: AuthorModel(),
                                                         createDate: $0.createdAt) }
                self?.view?.update(with: models)
            case .failure:
                break;
            }
        })
    }
}
