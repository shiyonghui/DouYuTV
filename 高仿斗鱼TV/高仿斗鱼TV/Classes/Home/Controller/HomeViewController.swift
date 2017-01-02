//
//  HomeViewController.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 16/12/3.
//  Copyright © 2016年 style_施. All rights reserved.
//

import UIKit

fileprivate let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
//MARK: 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleVIew = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH , width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleVIew(frame: titleFrame, titles: titles)
//        titleView.backgroundColor = UIColor.orange
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = { [weak self] in
//        1. 确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH
        
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        //2.确定所有的子控制器
        var childVcs = [UIViewController]()
        //添加控制器
        childVcs.append(RecommandViewController())
        
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    //MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置UI界面
        setupUI()
        
    }
    
}


// MARK: -设置UI界面
extension HomeViewController {
    
    fileprivate func setupUI() {
        // 不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        // 1.设置导航栏
        setupNavigationBar()
        
        // 2.添加TitleVIew
         view.addSubview(pageTitleView)
        //3.添加ContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
    }
    fileprivate func setupNavigationBar() {
        // 1.设置左侧的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo_66x26_")
       
        //2.设置左侧的item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history_26x26_", highImageName: "Image_my_history_click_22x22_", size: size)

        let searchItem = UIBarButtonItem(imageName: "btn_search_22x22_", highImageName: "btn_search_clicked_22x22_", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan_22x22_", highImageName: "Image_scan_click_22x22_", size: size)  
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}


//MARK 遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleVIew, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK 遵守PageContenViewDelegate协议
extension HomeViewController : PageContenViewDelegate {
    func pageContenView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}








