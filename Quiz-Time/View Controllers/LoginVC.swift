//
//  LoginVC.swift
//  Quiz-Time
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    private let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }

    private func setUpViews() {
        self.view.addSubview(loginView)
    }
}

