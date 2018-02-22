//
//  CreateCategoryVC.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SVProgressHUD

class CreateCategoryVC: UIViewController {
    
    private let createCategoryView = CreateCategoryView()
    
    private var databaseService = DatabaseService()
    private var currentUserID: String {
        return AuthUserService.manager.getCurrentUser()!.uid
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseService.delegate = self
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
        guard let categoryName = createCategoryView.categoryTextField.text, !categoryName.isEmpty else {
            let errorAlert = Alert.createErrorAlert(withMessage: "Can't create an empty category!!", andCompletion: nil)
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        SVProgressHUD.show()
        let category = Category(name: categoryName, userID: currentUserID)
        databaseService.addCategory(category)
    }
    
    @objc private func cancelButtonPressed() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension CreateCategoryVC: DatabaseServiceDelegate {
    func didAddCategory(_ databaseService: DatabaseService) {
        SVProgressHUD.dismiss()
        let successAlert = Alert.createSuccessAlert(withMessage: "You added a category!!!", andCompletion: nil)
        self.present(successAlert, animated: true, completion: nil)
    }
    func didFailAddingCategory(_ databaseService: DatabaseService, errorMessage: String) {
        SVProgressHUD.dismiss()
        let errorAlert = Alert.createErrorAlert(withMessage: "Couldn't add the category!!!\nPlease check your network connection.\n\(errorMessage)", andCompletion: nil)
        self.present(errorAlert, animated: true, completion: nil)
    }
}
