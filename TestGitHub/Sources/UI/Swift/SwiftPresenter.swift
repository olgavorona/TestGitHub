//
//  SwiftPresenter.swift
//  TestGitHub
//
//  Created by Olga Vorona on 23.12.2020.
//

import Foundation

final class SwiftPresenter {
    
    private lazy var trendingService: TrendingServiceProtocol = {
        return TrendingService()
    }()
    
    private var viewModels: [RepoModel] = []
    weak var view: SwiftViewInput?
    
    private func model(from entity: TrendingEntity) -> RepoModel {

        return RepoModel(title: entity.repo,
                          description: entity.desc,
                          stars: entity.stars,
                          createDate:"")
    }
}

extension SwiftPresenter: SwiftViewOutput {
    
    func getItems(index: Int) {
        trendingService.getTrending(type: index, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                let models = items.map { self.model(from: $0)}
                self.view?.update(with: models)
            case .failure:
                self.view?.showError()
                break;
            }
        })
    }
}
