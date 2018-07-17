//
// Created by Kamil Powałowski on 17.07.2018.
// Copyright (c) 2018 10Clouds. All rights reserved.
//

import Foundation
import UIKit

final class Button: UIButton {

    // MARK: - Public

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.2, animations: {
             self.transform = CGAffineTransform(scaleX: 1.32, y: 1.32)
        })
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
}
