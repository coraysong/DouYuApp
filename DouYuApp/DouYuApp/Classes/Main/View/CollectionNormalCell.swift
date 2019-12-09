//
//  CollectionNormalCell.swift
//  DouYuApp
//
//  Created by 宋超 on 2019/12/9.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {
    //1.image
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "Img_default")
        iv.clipsToBounds = true
        return iv
    }()
    
    //2.icon
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "home_live_cate_normal")
        iv.clipsToBounds = true
        return iv
    }()
    //3.title
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.text = "主播来啦"
        tl.font = UIFont.systemFont(ofSize: 11.0)
        tl.textColor = .lightGray
        return tl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconImageView)
        iconImageView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 14, height: 14)
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: iconImageView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 0, height: 0)
        addSubview(titleLabel)
        titleLabel.anchor(top: nil, left: iconImageView.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 11, paddingBottom: 10, paddingRight: 0, width: 300, height: 11)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
