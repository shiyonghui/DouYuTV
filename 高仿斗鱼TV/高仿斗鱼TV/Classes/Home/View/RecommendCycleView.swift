//
//  RecommendCycleView.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 2017/1/1.
//  Copyright © 2017年 style_施. All rights reserved.
//

import UIKit
let kCycleCellID = "kCycleCellID"
class RecommendCycleView: UIView {
    //定义属性
    var cycleModels : [CycleModel]? {
        didSet {
            //刷新 collectionView
            collectionView.reloadData()
            //设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    //系统回调函数
    override func awakeFromNib() {
        //设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing(rawValue: 0)
        //注册cell
        collectionView.register(UINib(nibName: "CollectionCycleCell",bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
       
    }

}
//MARK 提供一个快速创建View的类方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}
//MARK 遵守UICollectionView的数据协议
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item]
        
        return cell
    } 
}

//MARK 遵守UICollectionView的代理协议
extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取滑动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        //计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width)
    }
}




