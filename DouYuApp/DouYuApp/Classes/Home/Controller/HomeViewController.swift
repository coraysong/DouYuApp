//
//  HomeViewController.swift
//  DouYuApp
//
//  Created by 宋超 on 2019/10/28.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40


class HomeViewController: UIViewController {
    
    //MARK:-懒加载属性
    private lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + (self?.navigationController?.navigationBar.frame.size.height)!, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        //titleView.backgroundColor = .orange
        titleView.delegate = self
        return titleView
    }()
    
    //title下面的四个控制器的付控制器view
    private lazy var pageContentView : PageContentView = { [weak self] in
        
        //1.确定内容的frame
        let contentH = kScreenH - (self?.navigationController?.navigationBar.frame.size.height)! - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + (self?.navigationController?.navigationBar.frame.size.height)! + kTitleViewH, width: kScreenW, height: contentH)
        //2.确定所有的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
            
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        return contentView
        
    }()
    
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
        //1.设置导航栏
        setupNavigationBar()
        
        //2.添加titleView
        view.addSubview(pageTitleView)
        
        //3.添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = .purple
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


//MARK:- 遵守PageTitleView的代理
extension HomeViewController : PagetitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
