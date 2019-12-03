//
//  PageContentView.swift
//  DouYuApp
//
//  Created by 宋超 on 2019/11/18.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit

private let ContentID = "ContentID"

class PageContentView: UIView {
    
    //MARK:- 定义属性
    private var childVcs : [UIViewController]
    //这里要注意循环引用，如果这里对HomeViewController强引用的话，会产生循环引用
    //另外添加weak之后会报错，因为，weak只能修饰可选类型
    private weak var parentViewController : UIViewController?
    
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

//MARK:- uiscrollview代理
extension PageContentView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

//MARK:- 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
