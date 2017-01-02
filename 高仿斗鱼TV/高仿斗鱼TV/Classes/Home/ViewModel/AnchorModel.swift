//
//  AnchorModel.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 2016/12/23.
//  Copyright © 2016年 style_施. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    //房间ID
    var room_id : Int = 0
    //房间图片对应的URLSring
    var vertical_src : String = ""
    //判断的是手机直播还是电脑直播
    var isVertical : Int = 0
    //房间名称
    var room_name : String = ""
    //主播名称
    var nickname : String = ""
    //观看人数
    var online : Int = 0
    //所在城市
    var anchor_city : String = ""
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
