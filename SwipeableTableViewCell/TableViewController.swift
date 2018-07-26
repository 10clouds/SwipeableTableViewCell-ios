//
//  Created by Kamil Powałowski on 11/07/2018.
//  Copyright © 2018 10Clouds. All rights reserved.
//

import UIKit

final class TableViewController: UIViewController {

    // MARK: - Properties

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "darkGreyColor")
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    private lazy var headerView: HeaderView = {
        let view = HeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var viewModel = TableViewModel()

    // MARK: - Public

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "darkGreyColor")
        layoutViews()
    }

    // MARK: - Private

    private func layoutViews() {
        layoutHeaderView()
        layoutTableView()
    }

    private func layoutHeaderView() {
        view.addSubview(headerView)
        let constraints = [
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 128)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutTableView() {
        view.addSubview(tableView)
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 13),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension TableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let viewModel = self.viewModel.cells[indexPath.row]
        cell.avatarImageView.image = UIImage(named: viewModel.imageName)
        cell.nameLabel.text = viewModel.name
        cell.titleLabel.text = viewModel.title
        cell.messageLabel.text = viewModel.fragment
        return cell
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
