//
//  TabBarController.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Appearance
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .lightPurple
        self.tabBar.unselectedItemTintColor = .white
        
        let homeVC = HomeVC()
        let firstNavVC = UINavigationController(rootViewController: homeVC)
        firstNavVC.tabBarItem = UITabBarItem(title: "Quiz", image: #imageLiteral(resourceName: "quizIcon"), tag: 0)
        firstNavVC.navigationBar.barTintColor = .lightPurple
        firstNavVC.navigationBar.isTranslucent = false
        
        let imageOne = UIImage(named: "quizIcon")?.withRenderingMode(.alwaysOriginal)
        firstNavVC.tabBarItem.selectedImage = imageOne
        
        let createFlashCardVC = CreateFlashCardVC()
        let secondNavVC = UINavigationController(rootViewController: createFlashCardVC)
        secondNavVC.tabBarItem = UITabBarItem(title: "Create Card", image: #imageLiteral(resourceName: "createCardIcon"), tag: 1)
        secondNavVC.navigationBar.barTintColor = .lightPurple
        secondNavVC.navigationBar.isTranslucent = false
        
        let imageTwo = UIImage(named: "createCardIcon")?.withRenderingMode(.alwaysOriginal)
        secondNavVC.tabBarItem.selectedImage = imageTwo
        
        self.viewControllers = [firstNavVC, secondNavVC]
    }

}
