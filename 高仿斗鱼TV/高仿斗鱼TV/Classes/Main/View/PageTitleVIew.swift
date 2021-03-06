//
//  PageTitleVIew.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 2016/12/12.
//  Copyright © 2016年 style_施. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleVIew, selectedIndex index : Int )
    
}
fileprivate let KscrollLineH : CGFloat = 2
fileprivate let kNNormalColor : (CGFloat, CGFloat, CGFloat) = (85,85,85)
fileprivate let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255,128,0)
class PageTitleVIew: UIView {
     
    
    //MARK : 定义属性
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    //MARK : 懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
         return scrollLine
    }()
    
  // NARK : 自定义构造函数
    init(frame: CGRect, titles : [String]) {
        
        self.titles = titles
        
        super.init(frame: frame)
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK :设置UI界面
extension PageTitleVIew {
    fileprivate func setupUI(){
        //1. 添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2. 添加title对应的label
        setupTitleLabels()
        
        //3. 设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }
    fileprivate func setupTitleLabels() {
        //确定label的一些frame的值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - KscrollLineH
        let labelY : CGFloat = 0
        for (index, title) in titles.enumerated(){
            //1.创建UILable
            let label = UILabel()
            //2.设置Label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(r: kNNormalColor.0, g: kNNormalColor.1, b: kNNormalColor.2)
            label.textAlignment = .center
            //3.设置label的frame
         
            let labelX : CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //5.给我们Label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    fileprivate func setupBottomLineAndScrollLine() {
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加scrollLine
        //2.1 获取第一个Label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)

        //2.2 设置scrollLine的属性
        addSubview(scrollLine)
        
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - KscrollLineH, width: firstLabel.frame.width, height: KscrollLineH)
        
        
    }
}

//MARK 监听Label的点击
extension PageTitleVIew {
    @objc fileprivate func titleLabelClick(tapGes : UITapGestureRecognizer){
       //获取当前Label的下标值
        guard let currentLabel = tapGes.view as? UILabel else {return}
        //如果是重复点击同一个Title 那么直接返回
        if currentLabel.tag == currentIndex { return }

        //获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        //切换文字颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNNormalColor.0, g: kNNormalColor.1, b: kNNormalColor.2)

        //保存最新下标值
        currentIndex = currentLabel.tag
        //滚动条位置发生改变
        let scrollLineX = CGFloat (currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
        }
    
    }

//MARK 对外暴露方法
extension PageTitleVIew {
    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int,targetIndex : Int){
        
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        //处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        //颜色渐变
        // 3.1.取出变化的范围
        let colorDelta = (kSelectColor.0 - kNNormalColor.0, kSelectColor.1 - kNNormalColor.1, kSelectColor.2 - kNNormalColor.2)
        
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: kNNormalColor.0 + colorDelta.0 * progress, g: kNNormalColor.1 + colorDelta.1 * progress, b: kNNormalColor.2 + colorDelta.2 * progress)
        
        // 4.记录最新的index
        currentIndex = targetIndex
    }
}
