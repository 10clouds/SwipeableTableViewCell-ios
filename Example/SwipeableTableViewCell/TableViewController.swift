//
//  Created by Kamil Powałowski on 11/07/2018.
//  Copyright © 2018 10Clouds.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

final class TableViewController: UIViewController {

    // MARK: - Properties

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Colors.darkGrey
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
        view.backgroundColor = Colors.darkGrey
        layoutViews()
    }

    // MARK: - Private

    private func layoutViews() {
        layoutHeaderView()
        layoutTableView()
    }

    private func layoutHeaderView() {
        view.addSubview(headerView)
        let topConstraint: NSLayoutConstraint = {
            if #available(iOS 11, *) {
                return headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            } else {
                return headerView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor)
            }
        }()
        let constraints = [
            topConstraint,
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
        cell.nameLabel.text = viewModel.name + String(indexPath.row)
        cell.titleLabel.text = viewModel.title
        cell.messageLabel.text = viewModel.fragment

        cell.onPrimaryButtonTap = { [weak self] in
            guard let `self` = self,
                let indexPath = tableView.indexPath(for: cell)
                else { return }
            self.viewModel.cells.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }

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
