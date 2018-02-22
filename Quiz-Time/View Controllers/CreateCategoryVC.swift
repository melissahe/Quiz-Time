//
//  CreateCategoryVC.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class CreateCategoryVC: UIViewController {
    
    private let createCategoryView = CreateCategoryView()
    
    private var databaseService = DatabaseService()
    private var currentUserID: String {
        return AuthUserService.manager.getCurrentUser()!.uid
    }
    
    private var categories: [Category] {
        didSet {
            //to do - reload table view
        }
    }
    
    init(categories: [Category]) {
        if categories.isEmpty {
            databaseService.getAllCategories(fromUserID: currentUserID, completion: { [weak self] (categories) in
                if let categories = categories {
                    self?.categories = categories
                } else {
                    let errorAlert = Alert.createErrorAlert(withMessage: "Couldn't load the categories!!", andCompletion: nil)
                    self?.present(errorAlert, animated: true, completion: nil)
                }
            })
        } else {
            self.categories = categories
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpNavigation()
    }
    
    private func setUpViews() {
        self.view.addSubview(createCategoryView)
    }
    
    private func setUpNavigation() {
        self.navigationController?.navigationBar.barTintColor = .lightPurple
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationItem.title = "Add A Category"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCategoryButtonPressed))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
    }
    
    @objc private func addCategoryButtonPressed() {
        
    }
    @objc private func cancelButtonPressed() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
