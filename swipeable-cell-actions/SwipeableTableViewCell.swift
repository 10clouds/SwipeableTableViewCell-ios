//
// Created by Kamil Powałowski on 16.07.2018.
// Copyright (c) 2018 10Clouds. All rights reserved.
//

import Foundation
import UIKit

open class SwipeableTableViewCell: UITableViewCell, UIScrollViewDelegate {

    // MARK: - Properties

    lazy var scrollViewContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.scrollsToTop = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 126)
        view.delegate = self
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var deleteButton: Button = {
        let view = Button(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.setImage(UIImage(named: "trash"), for: .normal)
        view.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        view.tintColor = UIColor.white
        view.backgroundColor = UIColor(named: "coralPinkColor")
        view.layer.cornerRadius = self.buttonDimension / 2
        view.clipsToBounds = true
        return view
    }()

    private lazy var featuredButton: Button = {
        let view = Button(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.setImage(UIImage(named: "star"), for: .normal)
        view.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        view.tintColor = UIColor.white
        view.backgroundColor = UIColor(named: "periwinkleColor")
        view.layer.cornerRadius = self.buttonDimension / 2
        view.clipsToBounds = true
        return view
    }()

    private let buttonDimension: CGFloat = 42

    private var deleteButtonTrailingConstraint: NSLayoutConstraint!
    private var deleteButtonHeightConstraint: NSLayoutConstraint!
    private var featuredButtonTrailingConstraint: NSLayoutConstraint!
    private var featuredButtonHeightConstraint: NSLayoutConstraint!

    // MARK: - Initialization

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutButtons()
        layoutScrollView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutScrollView()
        layoutButtons()
    }

    // MARK: - Public
    open override func prepareForReuse() {
        super.prepareForReuse()
        scrollView.contentOffset = .zero
    }

    // MARK: - Private

    private func layoutScrollView() {
        super.contentView.addSubview(scrollView)
        super.contentView.addGestureRecognizer(scrollView.panGestureRecognizer)

        scrollView.addSubview(scrollViewContentView)

        let scrollViewContentViewHeightConstraint = scrollViewContentView.widthAnchor
            .constraint(equalTo: scrollView.widthAnchor, multiplier: 1)
        scrollViewContentViewHeightConstraint.priority = .defaultLow

        let constraints = [
            scrollView.leadingAnchor.constraint(equalTo: super.contentView.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: super.contentView.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: super.contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: super.contentView.bottomAnchor),

            scrollViewContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            scrollViewContentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1),
            scrollViewContentViewHeightConstraint
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutButtons() {
        contentView.addSubview(featuredButton)
        contentView.addSubview(deleteButton)

        deleteButtonTrailingConstraint = deleteButton.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -16
        )
        deleteButtonHeightConstraint = deleteButton.heightAnchor.constraint(equalToConstant: 42)
        featuredButtonTrailingConstraint = featuredButton.trailingAnchor.constraint(
            equalTo: deleteButton.trailingAnchor, constant: -22 - buttonDimension
        )
        featuredButtonHeightConstraint = featuredButton.heightAnchor.constraint(equalToConstant: 42)

        let constraints: [NSLayoutConstraint] = [
            deleteButtonTrailingConstraint,
            deleteButtonHeightConstraint,
            deleteButton.widthAnchor.constraint(equalTo: deleteButton.heightAnchor, multiplier: 1),
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            featuredButtonTrailingConstraint,
            featuredButtonHeightConstraint,
            featuredButton.widthAnchor.constraint(equalTo: featuredButton.heightAnchor, multiplier: 1),
            featuredButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setAnimationState(for progress: CGFloat) {
        let progress = min(max(progress, 0), 1)
        switch progress {
        case (0.0..<0.75):
            let partProgress = progress / 0.75
            deleteButtonTrailingConstraint.constant = -16 - (31 * partProgress)
            deleteButtonHeightConstraint.constant = buttonDimension * 1.32
            featuredButtonTrailingConstraint.constant = 0
            deleteButton.imageView?.alpha = 0
        case (0.75...1.0):
            let partProgress = (progress - 0.75) / 0.25
            deleteButtonTrailingConstraint.constant = -16 - (31 * (1 - partProgress))
            deleteButtonHeightConstraint.constant = buttonDimension * (0.32 * (1 - partProgress)) + buttonDimension
            featuredButtonTrailingConstraint.constant = (-22 - buttonDimension) * partProgress
            deleteButton.imageView?.alpha = partProgress
        default: break
        }

        deleteButton.layer.cornerRadius = deleteButtonHeightConstraint.constant / 2
        featuredButtonHeightConstraint.constant = deleteButtonHeightConstraint.constant
        featuredButton.layer.cornerRadius = deleteButton.layer.cornerRadius
        featuredButton.imageView?.alpha = deleteButton.imageView?.alpha ?? 1
    }

    // MARK: - UIScrollViewDelegate

    public func scrollViewWillEndDragging(
        _ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        if scrollView.contentOffset.x > (scrollView.contentInset.right / 2) {
            targetContentOffset.pointee.x = scrollView.contentInset.right
        } else {
            targetContentOffset.pointee = .zero
        }
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        deleteButton.isHidden = scrollView.contentOffset.x < 8
        featuredButton.isHidden = scrollView.contentOffset.x < 8
        setAnimationState(for: scrollView.contentOffset.x / scrollView.contentInset.right)
    }
}
