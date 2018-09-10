//
//  ButtonConnector.swift
//  SwipeableTableViewCell
//
//  Created by Joanna Kubiak on 26.07.2018.
//  Copyright © 2018 10Clouds. All rights reserved.
//


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
