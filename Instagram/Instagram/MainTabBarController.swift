//
//  MainTabBarController.swift
//  Instagram
//
//  Created by 宋超 on 2019/9/9.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        let redVC = UIViewController()
        redVC.view.backgroundColor = .red
        
        
        
        
        let layout = UICollectionViewFlowLayout()
        
        
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        let navController = UINavigationController(rootViewController: userProfileController)
        
        navController.tabBarItem.image = UIImage(named: "profile_unselected")
        navController.tabBarItem.selectedImage = UIImage(named: "profile_selected")
        tabBar.tintColor = .black
        
        viewControllers = [navController]
        
    }
}
