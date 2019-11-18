//
//  UIBarButtonItem-Extension.swift
//  DouYuApp
//
//  Created by 宋超 on 2019/10/28.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
    class func creatItem(imageName: String, highLightImageName: String, size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highLightImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
     */
    convenience init(imageName: String, highLightImageName: String, size: CGSize = CGSize.zero) {
        
        //1.创建UIButton
        let btn = UIButton()
        //2.创建btn图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highLightImageName), for: .highlighted)
        //3.设置btn的尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView:btn)
    }
}
