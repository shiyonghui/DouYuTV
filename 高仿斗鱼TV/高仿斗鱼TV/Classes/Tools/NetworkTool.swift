//
//  NetworkTool.swift
//  高仿斗鱼TV
//
//  Created by 施永辉 on 2016/12/21.
//  Copyright © 2016年 style_施. All rights reserved.
//

import UIKit
import Alamofire
//定义请求方式的枚举
enum MethodType{
    case get
    case post
}
class NetWorkTools{
    class func requestData(_ URLString : String ,parameters : [String : NSString]? = nil,finishedCallback : @escaping (_ result : AnyObject) -> ()){
        Alamofire.request(URLString,parameters : parameters).responseJSON { response in
            guard let result = response.result.value else{return}
            finishedCallback(result as AnyObject)
        }
    }
}
