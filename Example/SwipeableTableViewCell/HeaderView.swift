//
//  HeaderView.swift
//  SwipeableTableViewCell
//
//  Created by Joanna Kubiak on 24.07.2018.
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

final class HeaderView: UIView {

    private struct Constants {
        static let imageDimension: CGFloat = 70
    }

    // MARK: - Properties

    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = Font.bold(26)
        return view
    }()

    lazy var messageLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = Font.regular(13)
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
        backgroundColor = Colors.darkGrey

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
    }

    private func layoutViews() {
        layoutElementsContainerView()
        layoutTitleLabel()
        layoutMessageLabel()
    }

    private func layoutElementsContainerView() {
        self.addSubview(elementsContainerView)
        let topConstraint: NSLayoutConstraint = {
            if #available(iOS 11, *) {
                return elementsContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
            } else {
                return elementsContainerView.topAnchor.constraint(equalTo: bottomAnchor)
            }
        }()
        let constraints = [
            topConstraint,
            elementsContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
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
            messageLabel.bottomAnchor.constraint(equalTo: elementsContainerView.bottomAnchor, constant: -30)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setColors() {
        elementsContainerView.backgroundColor = Colors.darkGrey
        titleLabel.textColor = Colors.white
        messageLabel.textColor = Colors.lightPinkGray.withAlphaComponent(0.6)
    }
}
