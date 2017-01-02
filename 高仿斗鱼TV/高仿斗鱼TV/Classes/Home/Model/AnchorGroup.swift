//
//  AnchorGroup.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 2016/12/23.
//  Copyright © 2016年 style_施. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    //该组中对应的房间信息
    //didSet属性监听器
    var room_list : [[String : NSObject]]?
        {
        didSet {
            guard let room_list = room_list else {return}
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    // 组显示的标题
    var tag_name : String = ""
    // 组显示的图标
    var icon_name : String = "home_header_normal_18x18_"
    //定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    //构造函数
    override init() {
    
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}









