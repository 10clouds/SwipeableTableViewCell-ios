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
        view.font = Font.archivoSemiBold(13)
        return view
    }()

    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = Font.archivoMedium(10)
        return view
    }()

    lazy var messageLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = Font.archivoRegular(10)
        return view
    }()

    lazy var dateLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white.withAlphaComponent(0.59)
        view.font = Font.archivoMedium(10)
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
        backgroundColor = UIColor(named: "backgroundColor")

        primaryButtonTintColor = UIColor.white
        primaryButtonBackgroundColor = UIColor(named: "coralPinkColor")
        primaryButtonImage = UIImage(named: "trash")

        secondaryButtonTintColor = UIColor.white
        secondaryButtonBackgroundColor = UIColor(named: "periwinkleColor")
        secondaryButtonImage = UIImage(named: "star")
        
        layoutViews()
        setNormalColors()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        highlighted ? setHighlightedColors() : setNormalColors()
    }

    // MARK: - Private

    private func layoutViews() {
        layoutElementsContainerView()
        layoutAvatarImageView()
        layoutNameLabel()
        layoutTitleLabel()
        layoutMessageLabel()
        layoutDateLabel()
    }

    private func layoutElementsContainerView() {
        scrollViewContentView.addSubview(elementsContainerView)
        let constraints = [
            elementsContainerView.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor, constant: 16),
            elementsContainerView.topAnchor.constraint(equalTo: scrollViewContentView.topAnchor, constant: 5),
            elementsContainerView.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor, constant: -16),
            elementsContainerView.bottomAnchor.constraint(equalTo: scrollViewContentView.bottomAnchor, constant: -5)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutAvatarImageView() {
        elementsContainerView.addSubview(avatarImageView)
        let constraints = [
            avatarImageView.leadingAnchor.constraint(equalTo: elementsContainerView.leadingAnchor, constant: 8),
            avatarImageView.topAnchor.constraint(equalTo: elementsContainerView.topAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 1),
            avatarImageView.heightAnchor.constraint(equalToConstant: 45)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutNameLabel() {
        elementsContainerView.addSubview(nameLabel)
        let constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 18),
            nameLabel.topAnchor.constraint(equalTo: elementsContainerView.topAnchor, constant: 13)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutTitleLabel() {
        elementsContainerView.addSubview(titleLabel)
        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutMessageLabel() {
        elementsContainerView.addSubview(messageLabel)
        let constraints = [
            messageLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            messageLabel.trailingAnchor.constraint(equalTo: elementsContainerView.trailingAnchor, constant: -9)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutDateLabel() {
        dateLabel.setContentHuggingPriority(.required, for: .horizontal)
        dateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        elementsContainerView.addSubview(dateLabel)
        let constraints = [
            dateLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            dateLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: elementsContainerView.trailingAnchor, constant: -9)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setNormalColors() {
        elementsContainerView.backgroundColor = UIColor(named: "duskColor")
        nameLabel.textColor = UIColor(named: "paleLilacColor")?.withAlphaComponent(0.76)
        titleLabel.textColor = UIColor(named: "blueGray")
        messageLabel.textColor = UIColor(named: "blueGray")?.withAlphaComponent(0.4)
    }

    private func setHighlightedColors() {
        elementsContainerView.backgroundColor = UIColor(named: "slateBlueColor")
        nameLabel.textColor = UIColor.white
        titleLabel.textColor = UIColor.white.withAlphaComponent(0.69)
        messageLabel.textColor = UIColor.white.withAlphaComponent(0.6)
    }
}
