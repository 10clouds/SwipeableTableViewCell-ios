//
//  Created by Kamil Powałowski on 13.07.2018.
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

import Foundation

struct CellViewModel {
    let imageName: String
    let name: String
    let title: String
    let fragment: String
}

final class TableViewModel {

    func moveToEndCell(at index: Int) {
        let lastIndex = cells.count - 1
        cells.swapAt(index, lastIndex)
    }

    var cells = [
        CellViewModel(
            imageName: "avatar1",
            name: "Lucille Guerrero",
            title: "\u{2022} Work",
            fragment: "Creating remarkable poster prints through…"
        ),
        CellViewModel(
            imageName: "avatar2",
            name: "Amy James",
            title: "\u{2022} Work",
            fragment: "Creating remarkable poster prints through…"
        ),
        CellViewModel(
            imageName: "avatar2",
            name: "Johanna Morrison",
            title: "\u{2022} Work",
            fragment: "Creating remarkable poster prints through…"
        ),
        CellViewModel(
            imageName: "avatar3",
            name: "Virgie Ballard",
            title: "\u{2022} Work",
            fragment: "Creating remarkable poster prints through…"
        ),
        CellViewModel(
            imageName: "avatar6",
            name: "Darrell Flores",
            title: "\u{2022} Work",
            fragment: "Creating remarkable poster prints through…"
        )
    ]
}
