//
//  NetworkTools.swift
//  DouYuApp
//
//  Created by 宋超 on 2019/12/17.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    
    class func requestData(type: MethodType, URLString : String, parameters : [String : NSString]? = nil, finishedCallBack : @escaping (_ : AnyObject) -> ()) {
        
        //1.获取类型
        let method = type == .GET ? Alamofire.HTTPMethod.get : Alamofire.HTTPMethod.post
        
        //2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            //3.获取结果
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            //4.将结果回调回去
            finishedCallBack(result as AnyObject)
        }
        
    }
}
