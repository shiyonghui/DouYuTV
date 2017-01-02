//
//  CollectionViewNormalCell.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 2016/12/17.
//  Copyright © 2016年 style_施. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: CollectionBaesCell {
//控件属性

    
    @IBOutlet weak var roomNNameLabel: UILabel!
   
    //定义模型属性
   override var anchor : AnchorModel? {
        didSet {
           //将属性传给父类
            super.anchor = anchor
            
            //房间名称
            roomNNameLabel.text = anchor?.room_name
        }
    }

}
