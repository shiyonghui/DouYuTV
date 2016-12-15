//
//  MainViewController.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 16/12/3.
//  Copyright © 2016年 style_施. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       addChildVc(storyName: "Home")
       addChildVc(storyName: "Live")
       addChildVc(storyName: "Follow")
       addChildVc(storyName: "Profile")
        
    }
    //连接StoryBoard
    private func addChildVc(storyName: String) {
        //1.通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()
        //2.将childVc作为子控制器
        addChildViewController(childVc!)
    }
}
