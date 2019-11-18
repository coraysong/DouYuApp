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
    private var parentViewController : UIViewController
    
    //MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView = {
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentID)
        
        return collectionView
    }()
    
    init(frame: CGRect, childVcs:[UIViewController], parentViewController: UIViewController) {
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
        //1.将所有的子控制器添加到父控制器中
        for childVc in childVcs {
            parentViewController.addChild(childVc)
        }
        
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
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
        
    }
    
    
}
