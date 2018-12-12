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
import SwipeableTableViewCell

final class TableViewCell: SwipeableTableViewCell {

    private struct Constants {
        static let avatarSize: CGFloat = 32
        static let horizontalMargin: CGFloat = 16
        static let verticalMargin: CGFloat = 16
    }

    // MARK: - Properties

    lazy var avatarImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var nameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = Font.medium(14)
        return view
    }()

    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = Font.bold(12)
        return view
    }()

    lazy var messageLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = Font.regular(12)
        return view
    }()

    private lazy var elementsContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initialization

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        horizontalMargin = 16

        buttonTintColor = UIColor.white
        buttonBackgroundColor = Colors.lightClaret
        buttonImage = UIImage(named: "trash")

        scrollViewContentView.layer.cornerRadius = 8
        scrollViewContentView.layer.masksToBounds = true
        scrollViewContentView.clipsToBounds = true
        
        layoutViews()
        setColors()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func layoutViews() {
        scrollViewContentView.addSubview(elementsContainerView)
        scrollViewContentView.addSubview(avatarImageView)
        elementsContainerView.addSubview(nameLabel)
        elementsContainerView.addSubview(titleLabel)
        elementsContainerView.addSubview(messageLabel)

        layoutElementsContainerView()
        layoutAvatarImageView()
        layoutNameLabel()
        layoutTitleLabel()
        layoutMessageLabel()
    }

    private func layoutAvatarImageView() {
        let constraints = [
            avatarImageView.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor, constant: Constants.horizontalMargin),
            avatarImageView.topAnchor.constraint(greaterThanOrEqualTo: scrollViewContentView.topAnchor, constant: Constants.verticalMargin),
            avatarImageView.bottomAnchor.constraint(lessThanOrEqualTo: scrollViewContentView.bottomAnchor, constant: -Constants.verticalMargin),
            avatarImageView.centerYAnchor.constraint(equalTo: scrollViewContentView.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 1),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatarSize)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutElementsContainerView() {
        let constraints = [
            elementsContainerView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Constants.horizontalMargin),
            elementsContainerView.topAnchor.constraint(equalTo: scrollViewContentView.topAnchor, constant: Constants.verticalMargin),
            elementsContainerView.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor, constant: -Constants.horizontalMargin),
            elementsContainerView.bottomAnchor.constraint(equalTo: scrollViewContentView.bottomAnchor, constant: -Constants.verticalMargin)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutNameLabel() {
        let constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: elementsContainerView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: elementsContainerView.topAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutTitleLabel() {
        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: elementsContainerView.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutMessageLabel() {
        let constraints = [
            messageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            messageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            messageLabel.trailingAnchor.constraint(equalTo: elementsContainerView.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setColors() {
        scrollViewContentView.backgroundColor = Colors.charcoalGreyTwo
        nameLabel.textColor = Colors.white
        titleLabel.textColor = Colors.lightClaret
        messageLabel.textColor = Colors.lightPinkGray
    }
}
