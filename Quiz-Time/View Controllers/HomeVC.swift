//
//  HomeVC.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeVC: UIViewController {

    private let homeView = HomeView()
    
    private var categories: [Category] = [] {
        didSet {
            homeView.categoryTableView.reloadData()
        }
    }
    
    private var currentUserID: String {
        return AuthUserService.manager.getCurrentUser()!.uid
    }
    
    private var databaseService = DatabaseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        self.navigationItem.title = "Quiz Time"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOutPressed))
        setUpViews()
    }
    
    private func setUpViews() {
        self.view.addSubview(homeView)
        
        homeView.categoryTableView.delegate = self
        homeView.categoryTableView.dataSource = self
        
        databaseService.getAllCategories(fromUserID: currentUserID) { (categories) in
            if let categories = categories {
                self.categories = categories
            }
        }
        
        homeView.categoryListButton.addTarget(self, action: #selector(categoryListButtonPressed), for: .touchUpInside)
        homeView.quizButton.addTarget(self, action: #selector(quizButtonPressed), for: .touchUpInside)
        homeView.addCategoryButton.addTarget(self, action: #selector(addCategoryButtonPressed), for: .touchUpInside)
    }
    
    @objc private func signOutPressed() {
        SVProgressHUD.show()
        AuthUserService.manager.signOut { [weak self] (signedOut) in
            SVProgressHUD.dismiss()
            if signedOut {
                let successAlert = Alert.createSuccessAlert(withMessage: "You have signed out smh 😒", andCompletion: { [weak self](_) in
                    self?.tabBarController?.dismiss(animated: true, completion: nil)
                })
                self?.present(successAlert, animated: true, completion: nil)
            } else {
                let errorAlert = Alert.createErrorAlert(withMessage: "Could not sign out", andCompletion: nil)
                self?.present(errorAlert, animated: true, completion: nil)
            }
        }
    }
    
    @objc private func categoryListButtonPressed() {
        homeView.categoryTableView.isHidden = false
    }
    
    @objc private func quizButtonPressed() {
        //needs dependency injection
        //check which category is currently selected
    }
    
    @objc private func addCategoryButtonPressed() {
        let createCategoryVC = CreateCategoryVC()
        let navVC = UINavigationController(rootViewController: createCategoryVC)
        self.present(navVC, animated: true, completion: nil)
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if categories.isEmpty {
            homeView.categoryTableView.isHidden = true
            return
        }
        let currentCategory = categories[indexPath.row]
        homeView.categoryListButton.setTitle(currentCategory.name, for: .normal)
        homeView.categoryTableView.isHidden = true
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return homeView.categoryListButton.layer.bounds.height
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(categories.count, 1)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        
        if categories.isEmpty {
            
            cell.categoryTitleLabel.text = "No categories added"
            
            return cell
        }
        
        let currentCategory = categories[indexPath.row]
        
        cell.categoryTitleLabel.text = currentCategory.name
        
        return cell
    }
}
