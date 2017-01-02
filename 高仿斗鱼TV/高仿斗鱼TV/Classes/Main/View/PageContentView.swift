//
//  PageContentView.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 2016/12/13.
//  Copyright © 2016年 style_施. All rights reserved.
//

import UIKit

protocol PageContenViewDelegate : class {
    func pageContenView(contentView : PageContentView, progress : CGFloat, sourceIndex : Int ,targetIndex : Int)
}


fileprivate let ContentCellID = "ContentID"

class PageContentView: UIView {
    //MARK ： 定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var starOffsetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContenViewDelegate?
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
        collectionView.delegate = self
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
//MARK 遵守UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        starOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断是否是点击事件
        if isForbidScrollDelegate { return }
        //获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        //判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > starOffsetX {
            //左滑
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            sourceIndex = Int(currentOffsetX / scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            //如果完全划过去
            if currentOffsetX - starOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else {
            //右滑
            progress  = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
        sourceIndex = childVcs.count - 1
            }
        }
        //将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContenView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
//MARK 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int){
        //记录需要进行执行的代理方法
        isForbidScrollDelegate = true
        //滚动正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
