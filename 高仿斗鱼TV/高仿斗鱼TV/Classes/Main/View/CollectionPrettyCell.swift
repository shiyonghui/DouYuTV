//
//  CollectionPrettyCell.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 2016/12/20.
//  Copyright © 2016年 style_施. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaesCell {
    //控件属性
      @IBOutlet weak var cityBtn: UIButton!
   

    //定义模型属性
   override var anchor : AnchorModel? {
        didSet {
            //将属性传给父类
            super.anchor = anchor

            //所在城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
        }
    }
    
}
