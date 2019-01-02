//
// Created by Kamil Powałowski on 16.07.2018.
// Copyright (c) 2018 10Clouds.
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

open class SwipeableTableViewCell: UITableViewCell {

    private struct Constants {
        static let buttonDimension: CGFloat = 62
        static let primaryButtonTrailingOffset: CGFloat = 16
        static let contentOffsetMovementDivider: CGFloat = 2
        static var maxOffset: CGFloat {
            return (2 * Constants.primaryButtonTrailingOffset + Constants.buttonDimension)
        }
        static var disconnectPoint: CGFloat {
            return Constants.buttonDimension + Constants.primaryButtonTrailingOffset
        }
    }

    private enum SlideDestination {
        case begin, end
    }

    // MARK: - Public Properties

    open var horizontalMargin: CGFloat = 16 {
        didSet {
            updateMargins()
        }
    }

    public lazy var scrollViewContentView: StretchyView = {
        let view = StretchyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.maxOffset = Constants.maxOffset
        return view
    }()

    public var buttonBackgroundColor: UIColor! {
        get { return buttonActiveBackgroundColor }
        set { buttonActiveBackgroundColor = newValue }
    }

    public var buttonTintColor: UIColor? {
        get { return button.tintColor }
        set { button.tintColor = newValue }
    }

    public var buttonTitle: String? {
        get { return button.title(for: .normal) }
        set { button.setTitle(newValue, for: .normal) }
    }

    public var buttonImage: UIImage? {
        get { return button.image(for: .normal) }
        set { button.setImage(newValue, for: .normal) }
    }

    /// An action performed on primary button tap
    public var onPrimaryButtonTap: (() -> Void)?

    // MARK: - Private Properties

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.scrollsToTop = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.contentInset.right = Constants.maxOffset * Constants.contentOffsetMovementDivider
        view.delegate = self
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var button: StretchyCircleButton = {
        let view = StretchyCircleButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.buttonDimension / 2
        view.clipsToBounds = true
        view.addTarget(self, action: #selector(handlePrimaryButtonTap), for: .touchUpInside)
        return view
    }()

    private var contentOffset: CGPoint {
        let offset = scrollView.layer.presentation()?.bounds.origin ?? scrollView.contentOffset
        let multiplier = 1.0 - 1.0 / Constants.contentOffsetMovementDivider
        return CGPoint(x: offset.x * multiplier, y: offset.y * multiplier)
    }

    private var buttonActiveBackgroundColor: UIColor!

    private var scrollViewContentViewLeadingConstraint: NSLayoutConstraint!
    private var scrollViewContentViewTrailingConstraint: NSLayoutConstraint!
    private var scrollViewContentViewWidthConstraint: NSLayoutConstraint!
    private var primaryButtonTrailingConstraint: NSLayoutConstraint!

    private var slideDestination: SlideDestination = .begin
    private var buttonScaleAnimationIsRunning = false

    private var slideTargetPoint: CGPoint {
        let velocity = scrollView.panGestureRecognizer.velocity(in: self)
        let max = CGPoint(x: Constants.maxOffset * Constants.contentOffsetMovementDivider, y: 0)
        if velocity.x > 0 {
            return .zero
        } else if velocity.x < 0 {
            return max
        } else {
            return contentOffset.x > Constants.maxOffset / 2 ? max : .zero
        }
    }

    // MARK: - Initialization

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Public functions

    open override func prepareForReuse() {
        super.prepareForReuse()
        scrollView.contentOffset = .zero
        slideDestination = .begin
        buttonScaleAnimationIsRunning = false
    }

    // MARK: Private functions

    private func setup() {
        addViews()
        layoutViews()
        backgroundColor = .clear

        contentView.addGestureRecognizer(scrollView.panGestureRecognizer)
        scrollView.panGestureRecognizer.addTarget(self, action: #selector(handlePan(_:)))
    }

    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .ended, .cancelled:
            startSlideAnimation(recognizer)
        default:
            break
        }
    }

    @objc private func handlePrimaryButtonTap() {
        guard contentOffset.x >= Constants.disconnectPoint else { return }
        onPrimaryButtonTap?()
    }

    private func startSlideAnimation(_ recognizer: UIPanGestureRecognizer) {
        let shouldStretch = slideDestination == .end
        let displayLink: CADisplayLink? = shouldStretch ? startDisplayLink() : nil

        let originalDuration: CGFloat = shouldStretch ? 1.5 : 0.8
        let duration = TimeInterval(
            abs(contentOffset.x - slideTargetPoint.x) / Constants.maxOffset * originalDuration / Constants.contentOffsetMovementDivider
        )

        let springDamping: CGFloat = shouldStretch ? 0.8 : 0.5
        let initialSpringVelocity: CGFloat = shouldStretch ? 0 : 1

        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: springDamping,
            initialSpringVelocity: initialSpringVelocity,
            options: .curveEaseIn,
            animations: {
                self.scrollView.setContentOffset(self.slideTargetPoint, animated: false)
            }, completion: { _ in
                self.buttonScaleAnimationIsRunning = false
                self.updateSlideDestination()
                displayLink?.invalidate()
            }
        )
    }

    private func startDisplayLink() -> CADisplayLink {
        let displayLink = CADisplayLink(target: self, selector: #selector(handleDisplayLink(_:)))
        displayLink.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
        return displayLink
    }

    @objc private func handleDisplayLink(_ displayLink: CADisplayLink) {
        updateShape()

        if contentOffset.x >= Constants.disconnectPoint && !buttonScaleAnimationIsRunning {
            buttonScaleAnimationIsRunning = true
            button.addScaleAnimation()
        }
    }

    private func updateShape() {
        guard slideDestination == .end else { return }
        scrollViewContentView.move(by: contentOffset.x)
        button.stretch(by: calulateCircleOffset(for: contentOffset.x))
        button.imageView?.alpha = contentOffset.x > Constants.buttonDimension / 2 + Constants.primaryButtonTrailingOffset ? 1 : 0
        if !button.isHighlighted {
            button.backgroundColor = contentOffset.x > Constants.disconnectPoint ? buttonActiveBackgroundColor : scrollViewContentView.backgroundColor
        }
    }

    private func calulateCircleOffset(for x: CGFloat) -> CGFloat {
        return max(0, -0.05263 * x * x + 5.211 * x - 97.37)
    }

    private func updateSlideDestination() {
        if contentOffset.x <= 5 {
            slideDestination = .end
        } else if contentOffset.x >= Constants.maxOffset {
            slideDestination = .begin
        }
    }
}

extension SwipeableTableViewCell: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewContentView.transform = CGAffineTransform(
            translationX: scrollView.contentOffset.x / Constants.contentOffsetMovementDivider,
            y: scrollView.contentOffset.y / Constants.contentOffsetMovementDivider
        )

        updateShape()
        updateSlideDestination()
    }
}

extension SwipeableTableViewCell {
    private func addViews() {
        contentView.addSubview(button)
        contentView.addSubview(scrollView)
        scrollView.addSubview(scrollViewContentView)
    }

    private func layoutViews() {
        layoutScrollView()
        layoutButton()
        updateMargins()
    }

    private func updateMargins() {
        scrollViewContentViewLeadingConstraint.constant = horizontalMargin
        scrollViewContentViewTrailingConstraint.constant = -horizontalMargin
        scrollViewContentViewWidthConstraint.constant = -2 * horizontalMargin
        primaryButtonTrailingConstraint.constant = -Constants.primaryButtonTrailingOffset - horizontalMargin
    }

    private func layoutScrollView() {
        let scrollViewContentViewHeightConstraint = scrollViewContentView.widthAnchor
            .constraint(equalTo: scrollView.widthAnchor, multiplier: 1)
        scrollViewContentViewHeightConstraint.priority = .defaultLow

        scrollViewContentViewLeadingConstraint = scrollViewContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        scrollViewContentViewTrailingConstraint = scrollViewContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        scrollViewContentViewWidthConstraint = scrollViewContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)

        let constraints: [NSLayoutConstraint] = [
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollViewContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1),
            scrollViewContentViewLeadingConstraint,
            scrollViewContentViewTrailingConstraint,
            scrollViewContentViewWidthConstraint,
            scrollViewContentViewHeightConstraint
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func layoutButton() {
        primaryButtonTrailingConstraint = button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)

        let constraints: [NSLayoutConstraint] = [
            primaryButtonTrailingConstraint,
            button.heightAnchor.constraint(equalToConstant: Constants.buttonDimension),
            button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
