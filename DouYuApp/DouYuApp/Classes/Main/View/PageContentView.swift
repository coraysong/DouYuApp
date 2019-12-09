//
//  PageContentView.swift
//  DouYuApp
//
//  Created by 宋超 on 2019/11/18.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contenView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let ContentID = "ContentID"

class PageContentView: UIView {
    
    //MARK:- 定义属性
    private var childVcs : [UIViewController]
    //这里要注意循环引用，如果这里对HomeViewController强引用的话，会产生循环引用
    //另外添加weak之后会报错，因为，weak只能修饰可选类型
    private weak var parentViewController : UIViewController?
    private var startOffSetX : CGFloat = 0
    private var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    //MARK:- 懒加载属性
    //闭包内部使用self也有可能造成循环引用，所以加上
    private lazy var collectionView : UICollectionView = { [weak self] in
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.scrollsToTop = false
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentID)
        
        return collectionView
    }()
    
    //因为这些控制器要加入到父控制器中，所以我们传入它的父控制器
    //自定义构造函数之后，一定要重写initwithCoder函数，即下面这个函数
    //MARK:- 自定义构造函数
    init(frame: CGRect, childVcs:[UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:- 设置UI界面
extension PageContentView {
    private func setupUI() {
        //FIXME: 这里不明白为什么要加入到父控制器
        //1.将所有的子控制器添加到父控制器中
//        for childVc in childVcs {
//            parentViewController.addChild(childVc)
//        }
        
        //2.添加UICollectionView,用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK:- 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentID, for: indexPath)
        //2.给cell设置内容
        //FIXME: 这里不明白为什么这样做,说是避免添加多次
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
        
    }
    
}

//MARK:- 遵守uiscrollview代理
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffSetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        //判断是左滑还是右滑
        //根据偏移量进行判断
        //1.定义获取需要的数据
        //需要获取index
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //2.判断是左滑还是右滑
        
        let currentOffSetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffSetX > startOffSetX{
            //左滑
            //1.计算progress
            progress = currentOffSetX / scrollViewW - floor(currentOffSetX / scrollViewW)
            //2.计算当前的sourceIndex
            sourceIndex = Int(currentOffSetX / scrollViewW)
            
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            //4.如果完全划过去
            if currentOffSetX - startOffSetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        } else {
            //右滑
            progress = 1 - (currentOffSetX / scrollViewW - floor(currentOffSetX / scrollViewW))
            //2.计算当前的targetIndex
            targetIndex = Int(currentOffSetX / scrollViewW)
            
            //3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        print("-----")
        
        //3.将progress/sourceIndex/targetIndex传递给titleView
        print("progress:\(progress) sourceIndex:\(sourceIndex) targetIndex:\(targetIndex)")
        delegate?.pageContentView(contenView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    
}

//MARK:- 对外暴露的方法
extension PageContentView {
    
    func setCurrentIndex(currentIndex : Int) {
        //1.记录y需要禁止执行代理方法
        isForbidScrollDelegate = true
        
        //2.滚动正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
