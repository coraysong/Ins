//
//  MainTabBarController.swift
//  Instagram
//
//  Created by 宋超 on 2019/9/9.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil {
            
            DispatchQueue.main.async {
                let loginController = LoginController()
                self.present(loginController,animated: true, completion: nil)
            }
            return
        }
        
        let redVC = UIViewController()
        redVC.view.backgroundColor = .red
        
        
        let layout = UICollectionViewFlowLayout()
        
        
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        let navController = UINavigationController(rootViewController: userProfileController)
        
        navController.tabBarItem.image = UIImage(named: "profile_unselected")
        navController.tabBarItem.selectedImage = UIImage(named: "profile_selected")
        tabBar.tintColor = .black
        
        viewControllers = [navController, UIViewController()]
        
    }
}
