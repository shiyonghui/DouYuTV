//
//  RecommendViewModel.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 2016/12/21.
//  Copyright © 2016年 style_施. All rights reserved.
//

import UIKit

class RecommendViewModel: NSObject {
  //MARK 懒加载属性
    lazy var cycleModels : [CycleModel] = [CycleModel]()
     lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
}

//MARK 发送网络请求
extension RecommendViewModel {
    //请求推荐数据
    func requestData(finishCallback : @escaping ()-> ()) {
            //0.定义参数
        let parameters = ["limit":"4","offset":"0","time": NSDate.getCurrentTime()]
        //创建Group
        let Group = DispatchGroup()
        
        
            //1.请求第一部分推荐数据
        Group.enter()
        
        let URLFirstString = "http://capi.douyucdn.cn/api/v1/getbigDataRoom"
        NetWorkTools.requestData(URLFirstString, parameters: ["time" : NSDate.getCurrentTime() as NSString] as [String : NSString]?){(result) in
            //1.将 result 转成字典类型
            guard let resultDict = result as? [String : NSObject] else{ return }
            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            //3.遍历字典，并且转成模型对象
            //1.创建组
//            let group = AnchorGroup()
            //2.设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot_18x18_"
            //3.获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            //离开组
            Group.leave()
            
        }
        Group.enter()
            //2.请求第二部分颜值数据
        let URLSectionString = "http://capi.douyucdn.cn/api/v1/getVerticalRoom"
        NetWorkTools.requestData(URLSectionString, parameters: parameters as [String : NSString]?){(result) in
            //1.将 result 转成字典类型
            guard let resultDict = result as? [String : NSObject] else{ return }
            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
        //3.遍历字典，并且转成模型对象
            //1.创建组
//            let group = AnchorGroup()
            //2.设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone_18x18_"
            
            //3.获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            Group.leave()
            
        }
            //3.请求后面部分游戏数据
        Group.enter()
        let URLRString = "http://capi.douyucdn.cn/api/v1/getHotCate"
        
        NetWorkTools.requestData(URLRString, parameters: parameters as [String : NSString]?){(result) in
            //1.将 result 转成字典类型
            guard let resultDict = result as? [String : NSObject] else{ return }
            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            //3.遍历数组，获取字典，并且将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            for group in self.anchorGroups {
                for anchor in group.anchors {
                   print(anchor)
                }
            }
        
            Group.leave()
            
        }
        //所有的数据都请求到后进行排序
        Group.notify(queue: DispatchQueue.main){
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
    //请求轮播图数据
    func requestCycleData(finishCallback : @escaping () -> ()){
        let URLString = "http://www.douyutv.com/api/v1/slide/6"
        NetWorkTools.requestData(URLString, parameters: ["version" : "2.300"]){(result) in
            //1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            //2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            //3.字典转模型对象
            for dict in dataArray {
                let cycle = CycleModel(dict: dict)
                self.cycleModels.append(cycle)

            }
            
            
            finishCallback()
    }
  }
}
