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
        let view = UIScrollView(frame: bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.scrollsToTop = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.delegate = self
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 160)
        view.isUserInteractionEnabled = false
        return view
    }()

    // MARK: - Initialization

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutScrollView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutScrollView()
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
}
