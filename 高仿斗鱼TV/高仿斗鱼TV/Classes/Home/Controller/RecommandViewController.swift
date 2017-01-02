//
//  RecommandViewController.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 2016/12/17.
//  Copyright © 2016年 style_施. All rights reserved.
//

import UIKit

fileprivate let kItemMargin : CGFloat = 10
fileprivate let kItemW = ( kScreenW - 3 * kItemMargin ) / 2
fileprivate let kNormalItemH = kItemW * 3 / 4
fileprivate let kPrettyItemH = kItemW * 4 / 3
fileprivate let kHeaderViewH : CGFloat = 50
fileprivate let kCycleViewH = kScreenW * 3 / 8

fileprivate let kNormalCellID = "kNormalCellID"
fileprivate let kHeaderViewID = "kHeaderViewID"
fileprivate let kPrettyViewID = "kPrettyViewID"

class RecommandViewController: UIViewController {

    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    //MARK 懒加载
    fileprivate lazy var collectionView : UICollectionView = {
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin,bottom: 0, right: kItemMargin)
        //创建UIcollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, . flexibleWidth]
        collectionView.register(UINib(nibName:"CollectionViewNormalCell",bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
       collectionView.register(UINib(nibName:"CollectionPrettyCell",bundle: nil), forCellWithReuseIdentifier: kPrettyViewID)
        
collectionView.register(UINib(nibName:"CollectionReusableView", bundle:nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
       return collectionView
    }()
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH , width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    //MARK 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        //发送网络请求
        lodData()
    }

 
}
//MARK 设置UI界面
extension RecommandViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
        //将cycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH, 0, 0, 0)
    }
}
//MARK 请求数据
extension RecommandViewController {
   
    fileprivate func lodData() {
       recommendVM.requestData { 
        self.collectionView.reloadData()
        }
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}
//MARK 遵守UICollectionView的数据源协议
extension RecommandViewController : UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         let group = recommendVM.anchorGroups[section]
          return group.anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        //定义cell
        var cell : CollectionBaesCell!
        //取出Cell
        if indexPath.section == 1 {
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyViewID, for: indexPath) as! CollectionPrettyCell
            
            
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
             
           
        }
        //将模型赋值给cell
        cell.anchor = anchor
          return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionReusableView
        
//  取出模型
 
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}





