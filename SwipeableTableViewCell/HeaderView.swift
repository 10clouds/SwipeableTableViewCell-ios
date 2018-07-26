//
//  HeaderView.swift
//  SwipeableTableViewCell
//
//  Created by Joanna Kubiak on 24.07.2018.
//  Copyright © 2018 10Clouds. All rights reserved.
//

import UIKit

final class HeaderView: UIView {

    private struct Constants {
        static let imageDimension: CGFloat = 70
    }

    // MARK: - Properties

//    lazy var imageView: UIImageView = {
//        let view = UIImageView(frame: .zero)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        //view.contentMode = .scaleAspectFill
//        //view.tintColor = UIColor.white
//        //view.backgroundColor = UIColor(named: "mediumGreyColor")
//        view.image = UIImage(named: "swipe")
//        //view.contentMode = .s
//        view.layer.cornerRadius = Constants.imageDimension / 2
//        view.clipsToBounds = true
//        return view
//    }()

    lazy var imageView: Button = {
        let view = Button(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "mediumGreyColor")
        view.layer.cornerRadius = Constants.imageDimension / 2
        view.clipsToBounds = true
        return view
    }()

    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = Font.sFProTextSemibold(18)
        return view
    }()

    lazy var messageLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = Font.sFProTextMedium(12)
        view.numberOfLines = 0
        return view
    }()

    private lazy var elementsContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "mediumDarkGreyColor")

        prepareHeaderView()
        layoutViews()
        setColors()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func prepareHeaderView() {
        titleLabel.text = "Swipe to delete"
        messageLabel.text = "Swipe your items left from list to delete the boxes."
        imageView.setImage(UIImage(named: "swipe"), for: .normal)
        //        imageView.image = UIImage(named: "swipe")?.withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5))
       // imageView.image?.resizableImage(withCapInsets: UIEdgeInsets(top: -20, left: -20, bottom: -20, right: -20))
    }

    private func layoutViews() {
        layoutElementsContainerView()
        layoutTitleLabel()
        layoutMessageLabel()
        layoutImageView()
    }

    private func layoutElementsContainerView() {
        self.addSubview(elementsContainerView)
        let constraints = [
            elementsContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            elementsContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            elementsContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            elementsContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutTitleLabel() {
        elementsContainerView.addSubview(titleLabel)
        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: elementsContainerView.leadingAnchor, constant: 27),
            titleLabel.topAnchor.constraint(equalTo: elementsContainerView.topAnchor, constant: 32),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutMessageLabel() {
        elementsContainerView.addSubview(messageLabel)
        let constraints = [
            messageLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutImageView() {
        elementsContainerView.addSubview(imageView)
        let constraints = [
            imageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 65),
            imageView.trailingAnchor.constraint(equalTo: elementsContainerView.trailingAnchor, constant: -39),
            imageView.centerYAnchor.constraint(equalTo: elementsContainerView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageDimension)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setColors() {
        elementsContainerView.backgroundColor = UIColor(named: "mediumDarkGreyColor")
        titleLabel.textColor = UIColor(named: "paleGrayColor")
        messageLabel.textColor = UIColor(named: "lightGrayColor")
        imageView.backgroundColor = UIColor(named: "mediumGreyColor")
    }

}
