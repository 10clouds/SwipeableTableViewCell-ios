//
//  Created by Kamil Powałowski on 13.07.2018.
//  Copyright © 2018 10Clouds. All rights reserved.
//

import Foundation
import UIKit

final class Font {
    static func archivoBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Archivo-Bold", size: size)!
    }

    static func archivoMedium(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Archivo-Medium", size: size)!
    }

    static func archivoSemiBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Archivo-SemiBold", size: size)!
    }

    static func archivoRegular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Archivo-Regular", size: size)!
    }
}
