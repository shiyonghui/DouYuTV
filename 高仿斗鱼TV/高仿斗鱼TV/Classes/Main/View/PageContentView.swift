//
//  PageContentView.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 2016/12/13.
//  Copyright © 2016年 style_施. All rights reserved.
//

import UIKit




fileprivate let ContentCellID = "ContentID"

class PageContentView: UIView {
    //MARK ： 定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    
    //MARK 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        //1. 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
//MARK :自定义构造函数
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


//MARK : 设置UI界面
extension PageContentView {
    fileprivate func setupUI() {
        //1.将所有的子控制器添加父控制器中
        for childvc in childVcs {
            parentViewController?.addChildViewController(childvc)
        }
        //2.添加UICollectionView
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        //给Cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childeVc = childVcs[indexPath.item]
        childeVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childeVc.view)
       return cell
    }
   
}
//MARK 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int){
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
