//
//  UIColor-Extension.swift
//  DouYuApp
//
//  Created by 宋超 on 2019/11/18.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
