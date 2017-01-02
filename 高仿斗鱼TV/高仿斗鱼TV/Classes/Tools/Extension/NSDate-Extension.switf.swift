//
//  NSDate-Extension.switf.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 2016/12/23.
//  Copyright © 2016年 style_施. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = nowDate.timeIntervalSince1970
        return  "\(interval)"
    }
}



