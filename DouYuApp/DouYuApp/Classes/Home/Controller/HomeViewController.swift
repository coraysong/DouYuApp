//
//  HomeViewController.swift
//  DouYuApp
//
//  Created by 宋超 on 2019/10/28.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置界面
        view.backgroundColor = .white
        setupUI()
        
    }
}

//MARK:-设置UI界面
extension HomeViewController {
    private func setupUI(){
        setupNavigationBar()
    }
    private func setupNavigationBar(){
        //设置左侧的item
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: btn)
        
        //设置右侧的item
        
        let size = CGSize(width: 40, height: 40)

        let historyItem = UIBarButtonItem(imageName: "image_my_history", highLightImageName: "Image_my_history_click", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", highLightImageName: "btn_search_clicked", size: size)

        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highLightImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}
