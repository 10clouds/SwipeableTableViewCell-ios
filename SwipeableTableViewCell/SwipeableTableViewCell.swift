//
// Created by Kamil Powałowski on 16.07.2018.
// Copyright (c) 2018 10Clouds. All rights reserved.
//

import Foundation
import UIKit

open class SwipeableTableViewCell: UITableViewCell, UIScrollViewDelegate {

    private struct Constants {
        static let buttonDimension: CGFloat = 42
        static let coralPink = UIColor(red: 255 / 255.0, green: 93 / 255.0, blue: 115 / 255.0, alpha: 1)
        static let periwinkle = UIColor(red: 119 / 255.0, green: 132 / 255.0, blue: 255 / 255.0, alpha: 1)
    }

    // MARK: - Properties

    lazy var scrollViewContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var primaryButtonBackgroundColor: UIColor? {
        get { return primaryButton.backgroundColor }
        set { primaryButton.backgroundColor = newValue }
    }

    var primaryButtonTintColor: UIColor? {
        get { return primaryButton.tintColor }
        set { primaryButton.tintColor = newValue }
    }

    var primaryButtonImage: UIImage? {
        get { return primaryButton.image(for: .normal) }
        set { primaryButton.setImage(newValue, for: .normal) }
    }

    var secondaryButtonBackgroundColor: UIColor? {
        get { return secondaryButton.backgroundColor }
        set { secondaryButton.backgroundColor = newValue }
    }

    var secondaryButtonTintColor: UIColor? {
        get { return secondaryButton.tintColor }
        set { secondaryButton.tintColor = newValue }
    }

    var secondaryButtonImage: UIImage? {
        get { return secondaryButton.image(for: .normal) }
        set { secondaryButton.setImage(newValue, for: .normal) }
    }

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

    private lazy var primaryButton: Button = {
        let view = Button(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        view.tintColor = UIColor.white
        view.backgroundColor = Constants.coralPink
        view.layer.cornerRadius = Constants.buttonDimension / 2
        view.clipsToBounds = true
        return view
    }()

    private lazy var secondaryButton: Button = {
        let view = Button(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        view.tintColor = UIColor.white
        view.backgroundColor = Constants.periwinkle
        view.layer.cornerRadius = Constants.buttonDimension / 2
        view.clipsToBounds = true
        return view
    }()

    private var primaryButtonTrailingConstraint: NSLayoutConstraint!
    private var primaryButtonHeightConstraint: NSLayoutConstraint!
    private var secondaryButtonTrailingConstraint: NSLayoutConstraint!
    private var secondaryButtonHeightConstraint: NSLayoutConstraint!

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
        contentView.addSubview(secondaryButton)
        contentView.addSubview(primaryButton)

        primaryButtonTrailingConstraint = primaryButton.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -16
        )
        primaryButtonHeightConstraint = primaryButton.heightAnchor.constraint(equalToConstant: 42)
        secondaryButtonTrailingConstraint = secondaryButton.trailingAnchor.constraint(
            equalTo: primaryButton.trailingAnchor, constant: -22 - Constants.buttonDimension
        )
        secondaryButtonHeightConstraint = secondaryButton.heightAnchor.constraint(equalToConstant: 42)

        let constraints: [NSLayoutConstraint] = [
            primaryButtonTrailingConstraint,
            primaryButtonHeightConstraint,
            primaryButton.widthAnchor.constraint(equalTo: primaryButton.heightAnchor, multiplier: 1),
            primaryButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            secondaryButtonTrailingConstraint,
            secondaryButtonHeightConstraint,
            secondaryButton.widthAnchor.constraint(equalTo: secondaryButton.heightAnchor, multiplier: 1),
            secondaryButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setAnimationState(for progress: CGFloat) {
        let progress = min(max(progress, 0), 1)
        switch progress {
        case (0.0..<0.75):
            let partProgress = progress / 0.75
            primaryButtonTrailingConstraint.constant = -16 - (31 * partProgress)
            primaryButtonHeightConstraint.constant = Constants.buttonDimension * 1.32
            secondaryButtonTrailingConstraint.constant = 0
            primaryButton.imageView?.alpha = 0
        case (0.75...1.0):
            let partProgress = (progress - 0.75) / 0.25
            primaryButtonTrailingConstraint.constant = -16 - (31 * (1 - partProgress))
            primaryButtonHeightConstraint.constant = Constants.buttonDimension * (0.32 * (1 - partProgress)) + Constants.buttonDimension
            secondaryButtonTrailingConstraint.constant = (-22 - Constants.buttonDimension) * partProgress
            primaryButton.imageView?.alpha = partProgress
        default: break
        }

        primaryButton.layer.cornerRadius = primaryButtonHeightConstraint.constant / 2
        secondaryButtonHeightConstraint.constant = primaryButtonHeightConstraint.constant
        secondaryButton.layer.cornerRadius = primaryButton.layer.cornerRadius
        secondaryButton.imageView?.alpha = primaryButton.imageView?.alpha ?? 1
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
        primaryButton.isHidden = scrollView.contentOffset.x < 8
        secondaryButton.isHidden = scrollView.contentOffset.x < 8
        setAnimationState(for: scrollView.contentOffset.x / scrollView.contentInset.right)
    }
}
