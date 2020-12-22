//
//  SwiftViewController.swift
//  TestGitHub
//
//  Created by Olga Vorona on 22.12.2020.
//

import UIKit

class SwiftViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.sectionHeaderHeight = 0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.register(RepoTableCell.self, forCellReuseIdentifier: String(describing: RepoTableCell.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        tableView.pin(to: view)
    }

}

extension SwiftViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
