//
//  RecommendViewController.swift
//  DouYuApp
//
//  Created by 宋超 on 2019/12/3.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {

    //MARK:- 懒加载属性
    
    private lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
    private lazy var collectionView : UICollectionView = { [unowned self] in
        
        //1.创建布局
        let layOut = UICollectionViewFlowLayout()
        layOut.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        //行间距
        layOut.minimumInteritemSpacing = 0
        //中间间距
        layOut.minimumLineSpacing = kItemMargin
        
        layOut.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        layOut.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        //创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layOut)
        
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(CollectionNormalCell.self, forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(CollectionPrettyViewCell.self, forCellWithReuseIdentifier: kPrettyCellID)
        
        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        
        
        return collectionView
    }()
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //1.设置UI界面
        setUpUI()
        
        //发送网络请求
        loadData()
    }

}

//MARK:- 设置UI界面内容
extension RecommendViewController {
    private func setUpUI() {
        view.addSubview(collectionView)
    }
}

//MARK:- 请求数据
extension RecommendViewController {
    private func loadData() {
        recommendVM.requestData()
    }
}


//遵守数据源协议
extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1.定义cell
        var cell: UICollectionViewCell!
        
        //2.取出cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
        } else {
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        
        headerView.backgroundColor = .white
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
}
