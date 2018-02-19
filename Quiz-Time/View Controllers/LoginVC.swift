//
//  LoginVC.swift
//  Quiz-Time
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

class LoginVC: UIViewController {

    private let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        setUpViews()
    }

    private func setUpViews() {
        self.view.addSubview(loginView)
        
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginView.createButton.addTarget(self, action: #selector(createButtonPressed), for: .touchUpInside)
    }
    
    @objc private func loginButtonPressed() {
        //login button pressed
        guard let emailText = loginView.emailTextField.text, !emailText.isEmpty else {
            let errorAlert = Alert.createErrorAlert(withMessage: "You must enter a valid email address.", andCompletion: nil)
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        guard let passwordText = loginView.passwordTextField.text, !passwordText.isEmpty else {
            let errorAlert = Alert.createErrorAlert(withMessage: "Please enter a password.", andCompletion: nil)
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        
        AuthUserService.manager.delegate = self
        AuthUserService.manager.signIn(withEmail: emailText, andPassword: passwordText) { (user, error) in
            if let error = error {
                let errorAlert = Alert.createErrorAlert(withMessage: error.localizedDescription, andCompletion: nil)
                self.present(errorAlert, animated: true, completion: nil)
            } else if let user = user {
                //to do - should present the regular view controller
                print(user)
            }
        }
    }
    
    @objc private func createButtonPressed() {
        let createAccountVC = CreateAccountVC()
        self.present(createAccountVC, animated: true, completion: nil)
    }
}

extension LoginVC: GIDSignInUIDelegate {
    //what happens when you click the google sign in button
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        if let error = error {
            print("error dispatching sign in: \(error)")
        } else {
            print("dispatched sign in")
        }
    }
}

extension LoginVC: AuthUserServiceDelegate {
    func didSignInWithGoogle(_ authUserService: AuthUserService, user: User) {
        print("did sign in with google")
        //should launch the regular view controller
    }
    func didFailSignInWithGoogle(_ authUserService: AuthUserService, errorMessage: String) {
        print("did fail sign in with google: \(errorMessage)")
        let errorAlert = Alert.createErrorAlert(withMessage: "Could not sign in:\n\(errorMessage)", andCompletion: nil)
        self.present(errorAlert, animated: true, completion: nil)
    }
}

