//
//  UIColor-Extension.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 2016/12/13.
//  Copyright © 2016年 style_施. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
        
    }
}

