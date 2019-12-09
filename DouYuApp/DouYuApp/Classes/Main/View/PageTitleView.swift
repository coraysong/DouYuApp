//
//  PageTitleView.swift
//  DouYuApp
//
//  Created by 宋超 on 2019/11/3.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit

//写class代表这个协议只能被类遵守，如果不写这个协议也有可能被结构体遵守
//MARK:- 定义协议
protocol PagetitleViewDelegate : class {
    func pageTitleView (titleView : PageTitleView, selectedIndex index : Int)
}

//MARK:- 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

//MARK:- PageTitle类
class PageTitleView: UIView {
    
    //MARK:- 定义属性
    private var currentIndex : Int = 0
    private var titles : [String]
    
    weak var delegate : PagetitleViewDelegate?
    
    //MARK:- 懒加载属性
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    //
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        //水平线不显示了
        scrollView.showsHorizontalScrollIndicator = false
        //当你想要点击直接回到第一行的话就必须禁用其他scrollview的这个属性
        scrollView.scrollsToTop = false
        //能滚动内容也不能超过这个范围
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
        setupBottomLineAndScrollLine()
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            //3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)


            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.添加label到scrollview中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //5.给label添加手势，可以监听点击事件
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = .lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加cscrollLine
        //2.1获取第一个label
        
        guard let firstLabel = titleLabels.first else{return}
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}


//MARK:- 监听label的点击
extension PageTitleView {
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer) {
        print("-------")
        //1.获取当前label，通过手势.view可以获取到当前点击的label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        //2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //3.切换文字的颜色
        oldLabel.textColor = .darkGray
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        //4.保存最新label的下标值
        currentIndex = currentLabel.tag
        
        //5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //6.通知代理做事情
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}


//MARK:- 对外暴露的方法
extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        //1.取出 sourceLabel 和 targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.颜色的渐变(复杂)
        //3.1取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        //3.2变化sourcelabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        //3.3变化targetlabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        //4.记录最新的index
        currentIndex = targetIndex
    }
}
