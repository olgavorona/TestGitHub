//
//  RepoModel.swift
//  TestGitHub
//
//  Created by Olga Vorona on 23.12.2020.
//

import Foundation

struct RepoModel {
    let name: String
    let description: String?
    let stars: Int
    let author: AuthorModel?
    let createDate: String?
}

