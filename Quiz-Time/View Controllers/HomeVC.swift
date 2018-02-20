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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Quiz Time"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOutPressed))
        setUpViews()
    }
    
    private func setUpViews() {
        self.view.addSubview(homeView)
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

}
