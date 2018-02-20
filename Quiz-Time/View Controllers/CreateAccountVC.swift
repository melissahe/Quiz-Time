//
//  CreateAccountVC.swift
//  Quiz-Time
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SVProgressHUD

class CreateAccountVC: UIViewController {

    private let createAccountView = CreateAccountView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    private func setUpViews() {
        self.view.addSubview(createAccountView)
        createAccountView.dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        createAccountView.createButton.addTarget(self, action: #selector(createButtonPressed), for: .touchUpInside)
        createAccountView.emailTextField.delegate = self
        createAccountView.passwordTextField.delegate = self
    }
    
    @objc private func dismissButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func createButtonPressed() {
        guard let emailText = createAccountView.emailTextField.text, !emailText.isEmpty else {
            let errorAlert = Alert.createErrorAlert(withMessage: "You must enter a valid email address.", andCompletion: nil)
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        guard let passwordText = createAccountView.passwordTextField.text, !passwordText.isEmpty else {
            let errorAlert = Alert.createErrorAlert(withMessage: "Please enter a password.", andCompletion: nil)
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        SVProgressHUD.show()
        AuthUserService.manager.createAccount(withEmail: emailText, andPassword: passwordText) { (user, error) in
            SVProgressHUD.dismiss()
            if let error = error {
                let errorAlert = Alert.createErrorAlert(withMessage: "Could not create an account:\n\(error.localizedDescription)", andCompletion: nil)
                self.present(errorAlert, animated: true, completion: nil)
            } else if let user = user {
                print(user)
                //successful creating account
                let successAlert = Alert.createAlert(withTitle: "Success!!", andMessage: "You created an account!!")
                Alert.addAction(withTitle: "Lol thanks 😂", style: .default, andCompletion: { (_) in
                    //present tab bar
                    let tabBarVC = TabBarController()
                    self.present(tabBarVC, animated: true, completion: nil)
                }, toAlertController: successAlert)
                self.present(successAlert, animated: true, completion: nil)
            }
        }
    }
}

extension CreateAccountVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
