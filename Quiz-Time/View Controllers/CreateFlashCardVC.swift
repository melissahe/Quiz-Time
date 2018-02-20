//
//  CreateFlashCardVC.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class CreateFlashCardVC: UIViewController {
    
    private let createFlashCardView = CreateFlashCardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        self.view.addSubview(createFlashCardView)
    }
    

}
