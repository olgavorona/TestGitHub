//
//  RepoTableCell.swift
//  TestGitHub
//
//  Created by Olga Vorona on 22.12.2020.
//

import UIKit

class RepoTableCell: UITableViewCell {
    @IBOutlet weak var title: UILabel?
    @IBOutlet weak var descriptionText: UILabel?
    @IBOutlet weak var stars: UILabel?
    @IBOutlet weak var creation: UILabel?
    
    func setup(with model: RepoModel) {
        title?.text = "\(model.author) \\ \(model.name)"
        descriptionText?.text = model.description
        stars?.text = model.stars
        creation?.text = model.createDate
    }
    
}
