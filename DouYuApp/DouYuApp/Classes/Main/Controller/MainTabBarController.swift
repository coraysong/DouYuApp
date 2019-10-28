//
//  MainTabBarController.swift
//  DouYuApp
//
//  Created by 宋超 on 2019/10/28.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupViewControllers()
        
    }
    
    func setupViewControllers() {
        
        //首页
        let homeController = HomeViewController()
        homeController.tabBarItem.image = UIImage(named: "btn_home_normal")
        homeController.tabBarItem.selectedImage = UIImage(named: "btn_home_selected")
        homeController.tabBarItem.title = "首页"
        let homeNavController = UINavigationController(rootViewController: homeController)
        //直播
        let searchNavController = templateNavController(selectedImage: "btn_column_selected", unselectedImage: "btn_column_normal", title: "直播")
        
        //关注
        let plusNavController = templateNavController(selectedImage: "btn_live_selected", unselectedImage: "btn_live_normal", title: "关注")
        
        //我的
        let likeNavController = templateNavController(selectedImage: "btn_user_selected", unselectedImage: "btn_user_normal", title: "我的")
        
        tabBar.tintColor = .orange
        viewControllers = [homeNavController,
                           searchNavController,
                           plusNavController,
                           likeNavController]
        
        //modify tab bar item insets
        guard let items = tabBar.items else {
            return
        }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(selectedImage:String, unselectedImage:String, title:String) -> UINavigationController {
        let controller = UIViewController()
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem.image = UIImage(named: unselectedImage)
        navController.tabBarItem.selectedImage = UIImage(named: selectedImage)
        navController.tabBarItem.title = title
        return navController
    }
}

