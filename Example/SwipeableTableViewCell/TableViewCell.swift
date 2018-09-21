//
//  Created by Kamil Powałowski on 11/07/2018.
//  Copyright © 2018 10Clouds. All rights reserved.
//

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
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()

    // MARK: - Initialization

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = Colors.darkGrey

        primaryButtonTintColor = UIColor.white
        primaryButtonBackgroundColor = Colors.darkClaret
        primaryButtonImage = UIImage(named: "trash")

        secondaryButtonTintColor = UIColor.white
        secondaryButtonBackgroundColor = Colors.mediumGrey
        secondaryButtonImage = UIImage(named: "star")
        
        layoutViews()
        setColors()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func layoutViews() {
        contentView.insertSubview(avatarImageView, at: 0)
        scrollViewContentView.addSubview(elementsContainerView)
        elementsContainerView.addSubview(nameLabel)
        elementsContainerView.addSubview(titleLabel)
        elementsContainerView.addSubview(messageLabel)

        layoutAvatarImageView()
        layoutElementsContainerView()
        layoutNameLabel()
        layoutTitleLabel()
        layoutMessageLabel()
    }

    private func layoutAvatarImageView() {
        let constraints = [
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalMargin),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalMargin),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 1),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatarSize)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutElementsContainerView() {
        let constraints = [
            elementsContainerView.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor, constant: Constants.avatarSize + 1.5 * Constants.horizontalMargin),
            elementsContainerView.topAnchor.constraint(equalTo: scrollViewContentView.topAnchor, constant: Constants.verticalMargin),
            elementsContainerView.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor, constant: -Constants.horizontalMargin),
            elementsContainerView.bottomAnchor.constraint(equalTo: scrollViewContentView.bottomAnchor, constant: -Constants.verticalMargin)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutNameLabel() {
        let constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: elementsContainerView.leadingAnchor, constant: 18),
            nameLabel.topAnchor.constraint(equalTo: elementsContainerView.topAnchor, constant: Constants.verticalMargin),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutTitleLabel() {
        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: elementsContainerView.topAnchor, constant: Constants.verticalMargin)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutMessageLabel() {
        let constraints = [
            messageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            messageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            messageLabel.trailingAnchor.constraint(equalTo: elementsContainerView.trailingAnchor, constant: -9)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setColors() {
        elementsContainerView.backgroundColor = Colors.mediumDarkGrey
        nameLabel.textColor = Colors.whiteGray
        titleLabel.textColor = Colors.lightClaret
        messageLabel.textColor = Colors.lightGray
    }
}
