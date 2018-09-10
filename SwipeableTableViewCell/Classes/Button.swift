//
// Created by Kamil Powałowski on 17.07.2018.
// Copyright (c) 2018 10Clouds. All rights reserved.
//

import Foundation
import UIKit

final class Button: UIButton {

    // MARK: - Public

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 1.32, y: 1.32) : .identity
            })
        }
    }
}
