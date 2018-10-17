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
        static let buttonDimension: CGFloat = 42
        static let buttonConnectorHorizontalOffset: CGFloat = 7
        static let primaryButtonTrailingOffset: CGFloat = -16
    }

    // MARK: - Properties

    public lazy var scrollViewContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    open var onSlide: ((CGFloat) -> Void)?

    public var primaryButtonBackgroundColor: UIColor!
    {
        get { return primaryButton.backgroundColor }
        set { primaryButton.backgroundColor = newValue
            buttonConnector.shapeColor = newValue
            primaryColor = newValue
        }
    }

    public var primaryButtonTintColor: UIColor? {
        get { return primaryButton.tintColor }
        set { primaryButton.tintColor = newValue }
    }

    public var primaryButtonImage: UIImage? {
        get { return primaryButton.image(for: .normal) }
        set { primaryButton.setImage(newValue, for: .normal) }
    }

    public var secondaryButtonBackgroundColor: UIColor!
    {
        get { return secondaryButton.backgroundColor }
        set {
            secondaryButton.backgroundColor = newValue
            secondaryColor = newValue
        }
    }


    public var secondaryButtonTintColor: UIColor? {
        get { return secondaryButton.tintColor }
        set { secondaryButton.tintColor = newValue }
    }

    public var secondaryButtonImage: UIImage? {
        get { return secondaryButton.image(for: .normal) }
        set { secondaryButton.setImage(newValue, for: .normal) }
    }

    /// An action performed on primary button tap
    public var onPrimaryButtonTap: (() -> Void)?

    /// An action performed on secondary button tap
    public var onSecondaryButtonTap: (() -> Void)?

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
        view.layer.cornerRadius = Constants.buttonDimension / 2
        view.clipsToBounds = true
        view.addTarget(self, action: #selector(handlePrimaryButtonTap), for: .touchUpInside)
        return view
    }()

    private lazy var secondaryButton: Button = {
        let view = Button(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        view.layer.cornerRadius = Constants.buttonDimension / 2
        view.clipsToBounds = true
        view.addTarget(self, action: #selector(handleSecondaryButtonTap), for: .touchUpInside)
        return view
    }()

    private lazy var buttonConnector: ButtonConnector = {
        let view = ButtonConnector(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    private var primaryButtonTrailingConstraint: NSLayoutConstraint!
    private var primaryButtonHeightConstraint: NSLayoutConstraint!
    private var secondaryButtonTrailingConstraint: NSLayoutConstraint!
    private var secondaryButtonHeightConstraint: NSLayoutConstraint!

    private var displayLink: CADisplayLink?
    private var startTime: CFTimeInterval?
    private var slideOutDuration: CFTimeInterval = 0.3
    private var slideOutCompletion: (() -> Void)?
    private var primaryColor: UIColor?
    private var secondaryColor: UIColor?

    // MARK: - Initialization

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutButtons()
        layoutScrollView()
        setupSlide()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutScrollView()
        layoutButtons()
        setupSlide()
    }

    // MARK: - Public

    /// Animates sliding out of the screen.
    func animateDelete(completion: (() -> Void)? = nil) {
        slideOutCompletion = completion
        displayLink = CADisplayLink(target: self, selector: #selector(handleSlideOut(displayLink:)))
        startTime = CFAbsoluteTimeGetCurrent()
        displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
    }

    // MARK: Private functions

    private func invalidateDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }

    @objc private func handleSlideOut(displayLink: CADisplayLink) {
        guard let startTime = startTime else {
            invalidateDisplayLink()
            return
        }
        let percent = CGFloat(CFAbsoluteTimeGetCurrent() - startTime) / CGFloat(slideOutDuration)
        if percent >= 0.99 {
            invalidateDisplayLink()

            slideOutCompletion?()
            slideOutCompletion = nil
            return
        }
        setJoinAnimationState(for: percent)
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
        scrollView.contentOffset = .zero
    }

    // MARK: - Private

    @objc private func handlePrimaryButtonTap() {
        onPrimaryButtonTap?()
    }

    @objc private func handleSecondaryButtonTap() {
        onSecondaryButtonTap?()
    }

    private func layoutScrollView() {
        super.contentView.addSubview(scrollView)
        super.contentView.addGestureRecognizer(scrollView.panGestureRecognizer)

        scrollView.addSubview(scrollViewContentView)

        let scrollViewContentViewHeightConstraint = scrollViewContentView.widthAnchor
            .constraint(equalTo: scrollView.widthAnchor, multiplier: 1)
        scrollViewContentViewHeightConstraint.priority = .defaultLow

        let constraints: [NSLayoutConstraint] = [
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
        contentView.addSubview(buttonConnector)
        contentView.addSubview(secondaryButton)
        contentView.addSubview(primaryButton)

        primaryButtonTrailingConstraint = primaryButton.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: Constants.primaryButtonTrailingOffset
        )
        primaryButtonHeightConstraint = primaryButton.heightAnchor.constraint(equalToConstant: Constants.buttonDimension)
        secondaryButtonTrailingConstraint = secondaryButton.trailingAnchor.constraint(equalTo: primaryButton.trailingAnchor)

        secondaryButtonHeightConstraint = secondaryButton.heightAnchor.constraint(equalToConstant: Constants.buttonDimension)

        let buttonConnectorLeadingConstraint = buttonConnector.leadingAnchor
            .constraint(equalTo: secondaryButton.trailingAnchor, constant: -Constants.buttonConnectorHorizontalOffset)

        buttonConnectorLeadingConstraint.priority = UILayoutPriority.defaultLow

        let buttonConnectorTrailingConstraint = buttonConnector.trailingAnchor
            .constraint(equalTo: primaryButton.leadingAnchor, constant: Constants.buttonConnectorHorizontalOffset)

        buttonConnectorTrailingConstraint.priority = UILayoutPriority.defaultLow

        let constraints: [NSLayoutConstraint] = [
            primaryButtonTrailingConstraint,
            primaryButtonHeightConstraint,
            primaryButton.widthAnchor.constraint(equalTo: primaryButton.heightAnchor, multiplier: 1),
            primaryButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            secondaryButtonTrailingConstraint,
            secondaryButtonHeightConstraint,
            secondaryButton.widthAnchor.constraint(equalTo: secondaryButton.heightAnchor, multiplier: 1),
            secondaryButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            buttonConnector.heightAnchor.constraint(equalToConstant: 15),
            buttonConnector.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buttonConnectorLeadingConstraint,
            buttonConnectorTrailingConstraint
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setupSlide() {
        onSlide = { contentOffset in
            self.secondaryButton.backgroundColor = contentOffset > 125
                ? self.secondaryColor
                : self.primaryColor
        }
    }

    private func setAnimationState(for progress: CGFloat) {
        let heightScale: CGFloat = 1.32
        let progress = min(max(progress, 0), 1)
        let partProgress = max(0, progress - 0.25) / 0.50

        primaryButtonTrailingConstraint.constant = Constants.primaryButtonTrailingOffset
            + (-2 * Constants.primaryButtonTrailingOffset + Constants.buttonDimension)
            * max(1 - partProgress, 0)

        switch progress {
        case (0.0..<0.75):
            primaryButtonHeightConstraint.constant = Constants.buttonDimension * heightScale
            secondaryButtonHeightConstraint.constant = Constants.buttonDimension * heightScale
            secondaryButtonTrailingConstraint.constant = 0
            primaryButton.imageView?.alpha = 0
        case (0.75...1.0):
            let partProgress = (progress - 0.75) / 0.25
            primaryButtonHeightConstraint.constant =  Constants.buttonDimension * (0.32 * (1 - partProgress)) + Constants.buttonDimension
            secondaryButtonHeightConstraint.constant = primaryButtonHeightConstraint.constant
            secondaryButtonTrailingConstraint.constant = (-22 - Constants.buttonDimension) * partProgress
            primaryButton.imageView?.alpha = partProgress
            buttonConnector.isHidden = partProgress == 1
        default: break
        }

        primaryButton.layer.cornerRadius = primaryButtonHeightConstraint.constant / 2
        secondaryButton.layer.cornerRadius = secondaryButtonHeightConstraint.constant / 2
        secondaryButton.imageView?.alpha = primaryButton.imageView?.alpha ?? 1
    }

    private func setJoinAnimationState(for progress: CGFloat) {
        let normalizedProgress = min(max(progress, 0), 1)
        let progress = normalizedProgress * normalizedProgress * normalizedProgress

        primaryButtonHeightConstraint.constant =  Constants.buttonDimension * (0.32 * progress) + Constants.buttonDimension
        secondaryButtonHeightConstraint.constant = primaryButtonHeightConstraint.constant

        let offset: CGFloat = 22

        primaryButtonTrailingConstraint.constant = (offset / 2 - Constants.buttonDimension) * progress + Constants.primaryButtonTrailingOffset
        secondaryButtonTrailingConstraint.constant = (-offset - Constants.buttonDimension) * (1 - progress)

        primaryButton.imageView?.alpha = 1 - progress
        buttonConnector.isHidden = progress == 0

        primaryButton.layer.cornerRadius = primaryButtonHeightConstraint.constant / 2
        secondaryButton.layer.cornerRadius = secondaryButtonHeightConstraint.constant / 2
    }
}

extension SwipeableTableViewCell: UIScrollViewDelegate {
    public func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
        ) {
        if scrollView.contentOffset.x > (scrollView.contentInset.right / 2) {
            targetContentOffset.pointee.x = scrollView.contentInset.right
        } else {
            targetContentOffset.pointee = .zero
        }
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        onSlide?(scrollView.contentOffset.x)
        primaryButton.isHidden = scrollView.contentOffset.x < 8
        secondaryButton.isHidden = scrollView.contentOffset.x < 8
        buttonConnector.isHidden = scrollView.contentOffset.x < 8
        setAnimationState(for: scrollView.contentOffset.x / scrollView.contentInset.right)
    }
}
