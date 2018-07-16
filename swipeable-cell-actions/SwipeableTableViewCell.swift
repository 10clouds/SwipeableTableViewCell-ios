//
//  Created by Kamil Powałowski on 11/07/2018.
//  Copyright © 2018 10Clouds. All rights reserved.
//

import UIKit

class SwipeableTableViewCell: UITableViewCell {

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

    // MARK: - Initialization

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor(named: "backgroundColor")
        contentView.layer.cornerRadius = 4
        contentView.clipsToBounds = true
        layoutViews()
        setNormalColors()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(
            contentView.frame,
            UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        )
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        highlighted ? setHighlightedColors() : setNormalColors()
    }

    // MARK: - Private

    private func layoutViews() {
        layoutAvatarImageView()
        layoutNameLabel()
        layoutTitleLabel()
        layoutMessageLabel()
        layoutDateLabel()
    }

    private func layoutAvatarImageView() {
        contentView.addSubview(avatarImageView)
        let constraints = [
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 1),
            avatarImageView.heightAnchor.constraint(equalToConstant: 45)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutNameLabel() {
        contentView.addSubview(nameLabel)
        let constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 18),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutTitleLabel() {
        contentView.addSubview(titleLabel)
        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutMessageLabel() {
        contentView.addSubview(messageLabel)
        let constraints = [
            messageLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutDateLabel() {
        dateLabel.setContentHuggingPriority(.required, for: .horizontal)
        dateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        contentView.addSubview(dateLabel)
        let constraints = [
            dateLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            dateLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setNormalColors() {
        contentView.backgroundColor = UIColor(named: "duskColor")
        nameLabel.textColor = UIColor(named: "paleLilacColor")?.withAlphaComponent(0.76)
        titleLabel.textColor = UIColor(named: "blueGray")
        messageLabel.textColor = UIColor(named: "blueGray")?.withAlphaComponent(0.4)
    }

    private func setHighlightedColors() {
        contentView.backgroundColor = UIColor(named: "slateBlueColor")
        nameLabel.textColor = UIColor.white
        titleLabel.textColor = UIColor.white.withAlphaComponent(0.69)
        messageLabel.textColor = UIColor.white.withAlphaComponent(0.6)
    }
}
