//
//  CollectionHeaderView.swift
//  DouYuApp
//
//  Created by 宋超 on 2019/12/3.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit

private let kImageW : CGFloat = 18

class CollectionHeaderView: UICollectionReusableView {
    
    private lazy var view : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 10))
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var image : UIImageView = {
        let image = UIImageView(frame: CGRect(x: 10, y: 20, width: kImageW, height: kImageW))
        image.backgroundColor = .lightGray
        return image
    }()
    
    private lazy var label : UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 20, width: kImageW, height: kImageW))
        label.backgroundColor = .lightGray
        label.text = "颜值"
        return label
    }()
    
    private lazy var button : UIButton = {
        let button = UIButton(frame: CGRect(x: 10, y: 20, width: kImageW, height: kImageW))
        button.backgroundColor = .lightGray
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension CollectionHeaderView {
    private func setupUI() {
        //1.添加 分割view
        addSubview(view)
        addSubview(image)
        addSubview(label)
    }
}
