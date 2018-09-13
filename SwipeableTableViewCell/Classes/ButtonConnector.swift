//
//  ButtonConnector.swift
//  SwipeableTableViewCell
//
//  Created by Joanna Kubiak on 26.07.2018.
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

final class ButtonConnector: UIView {

    // MARK: - Properties

    var shapeColor: UIColor? {
        didSet {
            shapeLayer.fillColor = shapeColor?.cgColor
        }
    }

    private let shapeLayer = CAShapeLayer()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(shapeLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.frame = bounds
        updatePath()
    }

    // MARK: - Private

    private func updatePath() {
        let path = UIBezierPath()
        let radius = bounds.width / 2.0

        path.addArc(
            withCenter: CGPoint(x: bounds.midX, y: bounds.minY - bounds.height / 1.47),
            radius: radius,
            startAngle: CGFloat.pi,
            endAngle: 0,
            clockwise: false
        )

        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))

        path.addArc(
            withCenter: CGPoint(x: bounds.midX, y: bounds.maxY + bounds.height / 1.47),
            radius: radius,
            startAngle: 0,
            endAngle: CGFloat.pi,
            clockwise: false
        )

        path.close()
        shapeLayer.path = path.cgPath
    }
}
