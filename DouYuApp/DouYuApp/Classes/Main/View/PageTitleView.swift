//
//  PageTitleView.swift
//  DouYuApp
//
//  Created by 宋超 on 2019/11/3.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    
    //MARK:- 定义属性
    private var titles : [String]
    
    //MARK:- 懒加载属性
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        //当你想要点击直接回到第一行的话就必须禁用其他scrollview的这个属性
        scrollView.scrollsToTop = false
//        scrollView.bounds = false
        return scrollView
    }()
    
    //MARK:- 自定义构造函数
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:- 设置UI界面
extension PageTitleView {
    private func setupUI() {
        //1.添加 scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        //2.添加title对应的label
        setupTitleLabels()
    }
    private func setupTitleLabels() {
        for(index, title) in titles.enumerated() {
            //1.创建UILabel
            let label = UILabel()
            //2.设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            //3.设置label的frame
//            let labelW = frame.width / CGFloat(title.count)
//            let labelH = <#value#>
//            let labelX = <#value#>
//            let labelY = <#value#>
//
//
//            label.frame =
        }
    }
}
