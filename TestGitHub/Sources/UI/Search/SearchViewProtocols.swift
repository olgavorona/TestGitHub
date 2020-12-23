//
//  SearchViewProtocols.swift
//  TestGitHub
//
//  Created by Olga Vorona on 23.12.2020.
//

import Foundation

protocol SearchViewInput: class {
    func update(with models: [RepoModel])
    func showError()
}

protocol SearchViewOutput {
    var view: SearchViewInput? { get set }
    func search(query: String)
}
