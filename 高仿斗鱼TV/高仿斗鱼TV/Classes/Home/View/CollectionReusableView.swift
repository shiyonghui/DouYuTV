//
//  CollectionReusableView.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 2016/12/17.
//  Copyright © 2016年 style_施. All rights reserved.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {

    //控件属性
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    //定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal_18x18_")
        }
    }
}
