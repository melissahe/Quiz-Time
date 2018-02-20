//
//  CreateFlashCardVC.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SVProgressHUD

class CreateFlashCardVC: UIViewController {
    private let createFlashCardView = CreateFlashCardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Create Flashcard"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCardButtonPressed))
        setUpViews()
    }
    
    private func setUpViews() {
        self.view.addSubview(createFlashCardView)
    }
    
    @objc private func addCardButtonPressed() {
        //to do
    }
}
