//
//  TimingFunctions.swift
//  FluidTabBarController
//
//  Created by Hubert Kuczyński on 17/07/2018.
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

import QuartzCore

internal struct TimingFunctions {
    static let values: [CAMediaTimingFunction] = [
        CAMediaTimingFunction(controlPoints: 0.25, 0, 0.00, 1),
        CAMediaTimingFunction(controlPoints: 0.20, 0, 0.80, 1),
        CAMediaTimingFunction(controlPoints: 0.42, 0, 0.58, 1),
        CAMediaTimingFunction(controlPoints: 0.27, 0, 0.00, 1),
        CAMediaTimingFunction(controlPoints: 0.50, 0, 0.50, 1),
    ]

    static func easeInEaseOut(_ value: CGFloat) -> CGFloat {
        return value < 0.5 ? 2 * value * value : -1 + (4 - 2 * value) * value
    }
}
