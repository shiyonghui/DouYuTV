//
//  UIBarButton-Extension.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 16/12/4.
//  Copyright © 2016年 style_施. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /*  最好用构造函数来
    class func createItem(imageName : String, highImageName : String, size : CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: UIControlState.normal)
        btn.setImage(UIImage(named: highImageName), for: UIControlState.highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
 */
    //便利构造函数 1>convenience开头 2>在构造函数中必须名曲调用一个设计的构造函数（self） = "" 这个为默认参数
   convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSize.zero) {
    //1.创建UIbutton
    let btn = UIButton()
    //2.设置图片
    btn.setImage(UIImage(named: imageName), for: UIControlState.normal)
    if highImageName != "" {
        btn.setImage(UIImage(named: highImageName), for: UIControlState.highlighted)
    }
    
    //3.设置btn尺寸
    if size == CGSize.zero{
        btn.sizeToFit()
    } else {
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
    }
    //4.创建UIBarBUttonItem
     self.init(customView: btn)
    }
}

 
