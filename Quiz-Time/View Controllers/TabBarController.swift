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
        let homeVC = HomeVC()
        let firstNavVC = UINavigationController(rootViewController: homeVC)
        firstNavVC.tabBarItem = UITabBarItem(title: "Quiz", image: #imageLiteral(resourceName: "quizIcon"), tag: 0)
        
        let createFlashCardVC = CreateFlashCardVC()
        let secondNavVC = UINavigationController(rootViewController: createFlashCardVC)
        secondNavVC.tabBarItem = UITabBarItem(title: "Create Card", image: #imageLiteral(resourceName: "createCardIcon"), tag: 1)
        
        self.viewControllers = [firstNavVC, secondNavVC]
    }

}
