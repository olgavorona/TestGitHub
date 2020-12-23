//
//  SwiftViewProtocols.swift
//  TestGitHub
//
//  Created by Olga Vorona on 23.12.2020.
//

import Foundation

protocol SwiftViewInput: class {
    func update(with models: [RepoModel])
}

protocol SwiftViewOutput {
    var view: SwiftViewInput? { get set }
    func getItems(index: Int)
}
