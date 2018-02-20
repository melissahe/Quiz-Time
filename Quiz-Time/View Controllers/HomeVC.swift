//
//  HomeVC.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    private let homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        self.view.addSubview(homeView)
    }
}
