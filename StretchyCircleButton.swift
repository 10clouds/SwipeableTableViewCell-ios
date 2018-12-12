//
//  Created by Hubert Kuczyński on 04/12/2018.
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

final class StretchyCircleButton: UIButton {

    public override class var layerClass: AnyClass {
        return StretchyCircleLayer.self
    }

    // MARK: - Public properties

    public override var backgroundColor: UIColor? {
        get {
            if let cgColor = stretchyCircleLayer.fillColor {
                return UIColor(cgColor: cgColor)
            }
            return nil
        }
        set {
            stretchyCircleLayer.fillColor = newValue?.cgColor
        }
    }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(
                withDuration: 0.25,
                delay: 0,
                options: .curveEaseInOut,
                animations: {
                    self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 1.12, y: 1.12) : .identity
                    self.backgroundColor = self.backgroundColor?.withAlphaComponent(self.isHighlighted ? 0.6 : 1)
                }
            )
        }
    }

    // MARK: - Private properties

    private var stretchyCircleLayer: StretchyCircleLayer {
        return layer as! StretchyCircleLayer
    }

    private var scaleAnimator: UIViewPropertyAnimator?

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = false
        stretchyCircleLayer.masksToBounds = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clipsToBounds = false
        stretchyCircleLayer.masksToBounds = false
    }

    // MARK: - Public methods

    func stretch(by offset: CGFloat) {
        stretchyCircleLayer.updatePath(withOffset: offset)
    }

    func addScaleAnimation() {
        guard scaleAnimator == nil else { return }
        let duration: TimeInterval = 0.3
        scaleAnimator = UIViewPropertyAnimator(
            duration: duration,
            dampingRatio: 0.1,
            animations: {
                self.animateScale(duration: duration) { [weak self] _ in
                    self?.scaleAnimator = nil
                }
            }
        )
        scaleAnimator?.startAnimation()
    }

    // MARK: - Private methods

    private func animateScale(duration: TimeInterval, completion: @escaping (Bool) -> Void) {
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: [],
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                        let scale: CGFloat = 1.2
                        self.transform = CGAffineTransform(scaleX: scale, y: scale)
                })
                UIView.addKeyframe(
                    withRelativeStartTime: 0.5, relativeDuration: 1, animations: {
                        self.transform = CGAffineTransform.identity
                })
            },
            completion: completion
        )
    }
}
