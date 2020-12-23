//
//  SwiftViewController.swift
//  TestGitHub
//
//  Created by Olga Vorona on 22.12.2020.
//

import UIKit
import PKHUD

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
        tableView.register(UINib(nibName: String(describing: RepoTableCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: RepoTableCell.self))
        return tableView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Swift Trending"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let items = ["Day", "Week", "Month"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(changeItem(sender:)), for: .valueChanged)
        return control
    }()
    
    private var models: [RepoModel] = []
    private var presenter: SwiftViewOutput = SwiftPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        presenter.view = self
        
        HUD.show(.progress)
        presenter.getItems(index: 0)
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(segmentControl)
        view.addSubview(titleLabel)
        
        UIView.activate(constraints: [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            segmentControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            segmentControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentControl.heightAnchor.constraint(equalToConstant: 44),
            
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 10)
        ].compactMap { $0 })
    }
    
    @objc func changeItem(sender: UISegmentedControl) {
        HUD.show(.progress)
        presenter.getItems(index: sender.selectedSegmentIndex)
    }

}

extension SwiftViewController: UITableViewDataSource, UITableViewDelegate {
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

extension SwiftViewController: SwiftViewInput {
    func update(with models: [RepoModel]) {
        HUD.hide()
        self.models = models
        tableView.reloadData()
    }
    
    func showError() {
        HUD.show(.labeledError(title: "Loading error", subtitle: nil))
        HUD.hide(afterDelay: 3.0)
    }
}
