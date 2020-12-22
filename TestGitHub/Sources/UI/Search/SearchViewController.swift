//
//  ViewController.swift
//  TestGitHub
//
//  Created by Olga Vorona on 19.12.2020.
//

import UIKit

final class SearchViewController: UIViewController {

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = UIColor.black
        searchBar.tintColor = UIColor.black
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        searchBar.layoutIfNeeded()
        searchBar.delegate = self
        return searchBar
    }()
    
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
        tableView.register(UINib(nibName: String(describing: RepoTableCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: RepoTableCell.self))
        return tableView
    }()

    private var models: [RepoModel] = []
    private var presenter: SearchViewOutput = SearchPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        addSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        UIView.activate(constraints: [
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10)
        ].compactMap { $0 })
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableCell.self)) as? RepoTableCell {
            cell.setup(with: models[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.search(query: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(false)
    }
}

extension SearchViewController: SearchViewInput {
    func update(with models: [RepoModel]) {
        self.models = models
        tableView.reloadData()
    }

}
