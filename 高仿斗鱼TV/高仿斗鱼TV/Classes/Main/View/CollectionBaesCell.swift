//
//  CollectionBaesCell.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 2016/12/27.
//  Copyright © 2016年 style_施. All rights reserved.
//

import UIKit

class CollectionBaesCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    //定义模型
    var anchor : AnchorModel? {
        didSet {
            //校验模型是否有值
            guard let anchor = anchor else{ return }
            // 取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else{
                onlineStr = "\((anchor.online))在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            //昵称显示
            nickNameLabel.text = anchor.nickname
            
            //设置封面图片
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL)
        }
    }

}
