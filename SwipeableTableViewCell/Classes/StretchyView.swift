//
//  Created by Hubert Kuczyński on 04/12/2018.
//  Copyright (c) 2018 10Clouds.
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

public class StretchyView: UIView {

    // MARK: - Public properties

    public var maxOffset: CGFloat = 40

    public override var backgroundColor: UIColor? {
        get {
            if let cgColor = shapeLayer.fillColor {
                return UIColor(cgColor: cgColor)
            }
            return nil
        }
        set {
            shapeLayer.fillColor = newValue?.cgColor
        }
    }

    // MARK: - Private properties

    private let shapeLayer = CAShapeLayer()
    private var currentOffset: CGFloat = 0

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(shapeLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(shapeLayer)
    }

    // MARK: - Public methods

    func move(by offset: CGFloat) {
        currentOffset = offset
        updateShape(withMovementOffset: currentOffset)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.frame = bounds
        updateShape(withMovementOffset: currentOffset)
    }

    // MARK: - Private methods

    private func calculateControlPointOffset(for offset: CGFloat, maxValue: CGFloat) -> CGFloat {
        return max(0, -4 / 3 * (maxValue / maxOffset / maxOffset) * offset * offset + 4 / 3 * (maxValue / maxOffset) * offset)
    }

    private func calculateHeightControlPointOffset(for x: CGFloat) -> CGFloat {
        return bounds.height / 2 - max(0, -0.03810 * x * x + 3.200 * x - 49.95)
    }

    private func calculateEasedOffset(for offset: CGFloat) -> CGFloat {
        let progress = min(1, max(0, offset / maxOffset))
        let easedProgress = TimingFunctions.easeInEaseOut(progress)
        return easedProgress * maxOffset
    }

    private func updateShape(withMovementOffset offset: CGFloat) {
        let easedOffset = calculateEasedOffset(for: offset)
        let boundsOffset = calculateControlPointOffset(for: easedOffset, maxValue: 50)
        let heightOffset =  calculateHeightControlPointOffset(for: easedOffset)
        let controlPointHeightOffset: CGFloat = max(
            bounds.height / 2,
            bounds.height / 2 - calculateControlPointOffset(for: easedOffset, maxValue: bounds.height / 2) + 3
        )
        let widthOutsideOffset = calculateControlPointOffset(for: easedOffset, maxValue: 400)
        let widthInsideOffset: CGFloat = calculateControlPointOffset(for: easedOffset, maxValue: 100)

        let path = CGMutablePath()

        path.move(to: .zero)
        path.addLine(to: CGPoint(x: bounds.maxX - widthOutsideOffset - boundsOffset, y: bounds.minY))
        path.addCurve(
            to: CGPoint(x: bounds.maxX - boundsOffset, y: bounds.minY + heightOffset),
            control1: CGPoint(x: bounds.maxX - boundsOffset, y: bounds.minY),
            control2: CGPoint(x: bounds.maxX - boundsOffset - widthInsideOffset, y: bounds.minY + controlPointHeightOffset)
        )
        path.addLine(to: CGPoint(x: bounds.maxX - boundsOffset, y: bounds.maxY - heightOffset))

        path.addCurve(
            to: CGPoint(x: bounds.maxX - widthOutsideOffset - boundsOffset, y: bounds.maxY),
            control1: CGPoint(x: bounds.maxX - widthInsideOffset - boundsOffset, y: bounds.maxY - controlPointHeightOffset),
            control2: CGPoint(x: bounds.maxX - boundsOffset, y: bounds.maxY)
        )
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.addLine(to: .zero)

        shapeLayer.path = path
    }
}
