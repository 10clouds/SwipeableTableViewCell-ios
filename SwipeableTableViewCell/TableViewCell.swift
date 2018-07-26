//
//  Created by Kamil Powałowski on 11/07/2018.
//  Copyright © 2018 10Clouds. All rights reserved.
//

import UIKit

final class TableViewCell: SwipeableTableViewCell {

    // MARK: - Properties

    lazy var avatarImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var nameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = Font.sFProTextMedium(14)
        return view
    }()

    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = Font.sFProDisplayBold(12)
        return view
    }()

    lazy var messageLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = Font.sFProTextRegular(12)
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
        backgroundColor = UIColor(named: "darkGreyColor")

        primaryButtonTintColor = UIColor.white
        primaryButtonBackgroundColor = UIColor(named: "mediumGreyColor")
        primaryButtonImage = UIImage(named: "trash")

        secondaryButtonTintColor = UIColor.white
        secondaryButtonBackgroundColor = UIColor(named: "darkClaretColor")
        secondaryButtonImage = UIImage(named: "star")
        
        layoutViews()
        setColors()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func layoutViews() {
        layoutElementsContainerView()
        layoutAvatarImageView()
        layoutNameLabel()
        layoutTitleLabel()
        layoutMessageLabel()
    }

    private func layoutElementsContainerView() {
        scrollViewContentView.addSubview(elementsContainerView)
        let constraints = [
            elementsContainerView.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor),
            elementsContainerView.topAnchor.constraint(equalTo: scrollViewContentView.topAnchor, constant: 13),
            elementsContainerView.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor, constant: -16),
            elementsContainerView.bottomAnchor.constraint(equalTo: scrollViewContentView.bottomAnchor, constant: -13)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutAvatarImageView() {
        scrollViewContentView.addSubview(avatarImageView)
        let constraints = [
            avatarImageView.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor, constant: 16),
            avatarImageView.trailingAnchor.constraint(equalTo: elementsContainerView.leadingAnchor, constant: -8),
            avatarImageView.topAnchor.constraint(equalTo: elementsContainerView.topAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 1),
            avatarImageView.heightAnchor.constraint(equalToConstant: 45)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutNameLabel() {
        elementsContainerView.addSubview(nameLabel)
        let constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: elementsContainerView.leadingAnchor, constant: 18),
            nameLabel.topAnchor.constraint(equalTo: elementsContainerView.topAnchor, constant: 13),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutTitleLabel() {
        elementsContainerView.addSubview(titleLabel)
        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: elementsContainerView.topAnchor, constant: 13)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutMessageLabel() {
        elementsContainerView.addSubview(messageLabel)
        let constraints = [
            messageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            messageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            messageLabel.trailingAnchor.constraint(equalTo: elementsContainerView.trailingAnchor, constant: -9)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setColors() {
        elementsContainerView.backgroundColor = UIColor(named: "mediumDarkGreyColor")
        nameLabel.textColor = UIColor(named: "whiteGrayColor")
        titleLabel.textColor = UIColor(named: "lightClaretColor")
        messageLabel.textColor = UIColor(named: "lightGrayColor")
    }
}
