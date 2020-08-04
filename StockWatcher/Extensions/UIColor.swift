//
//  UIColor.swift
//  Stocks
//
//  Created by Milo Hill on 01/05/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }

    static var stocksTheme: UIColor {
        return UIColor(red: 220, green: 58, blue: 58)
    }
}
