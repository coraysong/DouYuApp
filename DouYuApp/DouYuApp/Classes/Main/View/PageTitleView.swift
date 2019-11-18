//
//  PageTitleView.swift
//  DouYuApp
//
//  Created by 宋超 on 2019/11/3.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {
    
    //MARK:- 定义属性
    private var titles : [String]
    
    //MARK:- 懒加载属性
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        //当你想要点击直接回到第一行的话就必须禁用其他scrollview的这个属性
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = .orange
        return scrollLine
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
        //3.设置底线和滚动的滑块
        setuoBottomLineAndScrollLine()
    }
    private func setupTitleLabels() {
        
        //0.确定一些frame值(不用每次遍历都创建的值，提高效率)
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
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
            let labelX : CGFloat = labelW * CGFloat(index)


            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.添加label到scrollview中
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    private func setuoBottomLineAndScrollLine() {
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = .lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加cscrollLine
        //2.1获取第一个label
        
        guard let firstLabel = titleLabels.first else{return}
        firstLabel.textColor = .orange
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}
