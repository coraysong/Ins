//
//  MainTabBarController.swift
//  Instagram
//
//  Created by 宋超 on 2019/9/9.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectorController)
            
            present(navController, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        if Auth.auth().currentUser == nil {
            
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navigationController = UINavigationController(rootViewController: loginController)
                self.present(navigationController,animated: true, completion: nil)
            }
            return
        }
        
        setupViewControllers()
        
    }
    
    func setupViewControllers() {
        
        //home
        let homeNavController = templateNavController(selectedImage: "home_selected", unselectedImage: "home_unselected")
        
        //search
        let searchNavController = templateNavController(selectedImage: "search_selected", unselectedImage: "search_unselected")
        
        //plus
        let plusNavController = templateNavController(selectedImage: "plus_unselected", unselectedImage: "plus_unselected")
        
        //like
        let likeNavController = templateNavController(selectedImage: "like_selected", unselectedImage: "like_unselected")
        
        
        //user profile
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        let userProfilenavController = UINavigationController(rootViewController: userProfileController)
        
        userProfilenavController.tabBarItem.image = UIImage(named: "profile_unselected")
        userProfilenavController.tabBarItem.selectedImage = UIImage(named: "profile_selected")
        tabBar.tintColor = .black
        
        viewControllers = [homeNavController,
                           searchNavController,
                           plusNavController,
                           likeNavController,
                           userProfilenavController]
        
        //modify tab bar item insets
        guard let items = tabBar.items else {
            return
        }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(selectedImage:String, unselectedImage:String) -> UINavigationController {
        let controller = UIViewController()
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem.image = UIImage(named: unselectedImage)
        navController.tabBarItem.selectedImage = UIImage(named: selectedImage)
        return navController
    }
}
