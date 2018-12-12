//
//  StretchyCircleLayer.swift
//  FluidTabBarController
//
//  Created by Hubert Kuczyński on 12/07/2018.
//  Copyright © 2018 10Clouds Sp. z o.o.
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
//

import UIKit

final class StretchyCircleLayer: CAShapeLayer {

    // MARK: Public properties

    override var frame: CGRect {
        didSet {
            path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        }
    }

    // MARK: Private properties

    private var radius: CGFloat {
        return bounds.size.height / 2.0
    }

    private var yOffsetMax: CGFloat {
        return bounds.size.height * 1.5
    }

    private let yOffset: CGFloat = 30.0

    private let timingFunctions: [CAMediaTimingFunction] = [
        TimingFunctions.values[0],
        TimingFunctions.values[2],
        TimingFunctions.values[1],
        TimingFunctions.values[1],
        TimingFunctions.values[1]
    ]

    // MARK: Public functions

    func updatePath(withOffset offset: CGFloat) {
        let pullDownCenter = CGPoint(x: bounds.size.height / 2.0, y: bounds.size.height / 2.0)
        let circlePath = stretchyCirclePathWithCenter(center: pullDownCenter, radius: radius, yOffset: min(offset, yOffsetMax))
        path = circlePath.cgPath
        masksToBounds = false
    }

    // MARK: Private functions

    private func stretchyCirclePathWithCenter(center: CGPoint, radius: CGFloat, yOffset: CGFloat = 0.0) -> UIBezierPath {
        guard yOffset != 0 else {
            return UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2.0 * CGFloat.pi, clockwise: true)
        }

        let radius = radius * (yOffsetMax - yOffset / 3) / yOffsetMax
        let lowerRadius = radius * (1 - yOffset / yOffsetMax)
        let yOffsetTop = yOffset / 4
        let yOffsetBottom = yOffset / 2.5
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 3 * CGFloat.pi / 2, endAngle: 0, clockwise: true)

        path.addArc(
            withCenter: center,
            radius: radius,
            startAngle: 0,
            endAngle: CGFloat.pi / 2,
            clockwise: true
        )

        path.addCurve(
            to: CGPoint(
                x: center.x - yOffset,
                y: center.y + lowerRadius
            ),
            controlPoint1: CGPoint(
                x: center.x - yOffsetTop,
                y: center.y  + radius
            ),
            controlPoint2: CGPoint(
                x: center.x - yOffset + yOffsetBottom,
                y: center.y + lowerRadius
            )
        )

        path.addArc(
            withCenter: CGPoint(
                x: center.x - yOffset,
                y: center.y
            ),
            radius: lowerRadius,
            startAngle: CGFloat.pi / 2,
            endAngle: 3 * CGFloat.pi / 2,
            clockwise: true
        )

        path.addCurve(
            to: CGPoint(
                x: center.x,
                y: center.y - radius
            ),
            controlPoint1: CGPoint(
                x: center.x - yOffset + yOffsetBottom,
                y: center.y - lowerRadius
            ),
            controlPoint2: CGPoint(
                x: center.x - yOffsetTop ,
                y: center.y - radius
            )
        )

        return path
    }
}
