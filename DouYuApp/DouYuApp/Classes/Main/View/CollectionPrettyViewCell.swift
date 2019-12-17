//
//  CollectionPrettyViewCell.swift
//  DouYuApp
//
//  Created by 宋超 on 2019/12/9.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit

class CollectionPrettyViewCell: UICollectionViewCell {
    
    
    //1.主图
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "live_cell_default_phone")
        iv.clipsToBounds = true
        return iv
    }()
    
    //2.在线人数
    
    let countLabel: UILabel = {
        let tl = UILabel()
        tl.text = "666在线"
        tl.font = UIFont.systemFont(ofSize: 11.0)
        tl.textColor = .black
        tl.backgroundColor = .lightGray
        tl.textAlignment = .center
        return tl
    }()
    
    
    //3.title
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.text = "你好"
        tl.font = UIFont.systemFont(ofSize: 13.0)
        tl.textColor = .lightGray
        return tl
    }()
    
    //4.button
    
    let button: UIButton = {
        let btn = UIButton()
        btn.imageView?.image = UIImage(named: "ico_location")
        btn.titleLabel?.text = "广州市"
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 11.0)
        btn.titleLabel?.textColor = .lightGray
        btn.backgroundColor = .black
        return btn
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(button)
        button.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 100, height: 14)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: nil, left: leftAnchor, bottom: button.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 0, height: 16)
        
        addSubview(countLabel)
        countLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 60, height: 20)
        
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: titleLabel.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
