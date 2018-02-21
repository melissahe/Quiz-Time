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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(resetButtonPressed))
        setUpViews()
        setUpGestures()
    }
    
    private func setUpViews() {
        self.view.addSubview(createFlashCardView)
        
        createFlashCardView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
            make.center.equalTo(self.view.snp.center)
        }
    }
    
    private func setUpGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped))
        
        createFlashCardView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func scrollViewTapped() {
        self.view.endEditing(true)
    }
    
    @objc private func addCardButtonPressed() {
        //to do
    }
    
    @objc private func resetButtonPressed() {
        //to do
    }
}
