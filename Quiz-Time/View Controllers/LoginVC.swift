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
import SVProgressHUD

class LoginVC: UIViewController {

    private let loginView = LoginView()
    
    fileprivate var currentlyLoggedIn = false //should be set back to false when logging out
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AuthUserService.manager.delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        setUpViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if currentlyLoggedIn {
            let tabBarVC = TabBarController()
            self.present(tabBarVC, animated: true, completion: nil)
        }
    }

    private func setUpViews() {
        self.view.addSubview(loginView)
        
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginView.createButton.addTarget(self, action: #selector(createButtonPressed), for: .touchUpInside)
        loginView.googleSignInButton.addTarget(self, action: #selector(googleSignInPressed), for: .touchUpInside)
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
        SVProgressHUD.show()
        AuthUserService.manager.delegate = self
        AuthUserService.manager.signIn(withEmail: emailText, andPassword: passwordText) { [weak self] (user, error) in
            SVProgressHUD.dismiss()
            self?.loginView.passwordTextField.text = nil
            if let error = error {
                let errorAlert = Alert.createErrorAlert(withMessage: error.localizedDescription, andCompletion: nil)
                self?.present(errorAlert, animated: true, completion: nil)
            } else if let user = user {
                print(user)
                let tabBarVC = TabBarController()
                self?.present(tabBarVC, animated: true, completion: nil)
            }
        }
    }
    
    @objc private func createButtonPressed() {
        let createAccountVC = CreateAccountVC()
        self.present(createAccountVC, animated: true, completion: nil)
    }
    
    @objc private func googleSignInPressed() {
        AuthUserService.manager.delegate = self
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
        SVProgressHUD.dismiss()
        //present tab bar VC
        let tabBarVC = TabBarController()
        self.present(tabBarVC, animated: true, completion: nil)
    }
    func didFailSignInWithGoogle(_ authUserService: AuthUserService, errorMessage: String) {
        print("did fail sign in with google: \(errorMessage)")
        SVProgressHUD.dismiss()
        let errorAlert = Alert.createErrorAlert(withMessage: "Could not sign in:\n\(errorMessage)", andCompletion: nil)
        self.present(errorAlert, animated: true, completion: nil)
    }
    func didSignOut(_ authUserService: AuthUserService) {
        self.currentlyLoggedIn = false
    }
    func didFailSignOut(_ authUserService: AuthUserService, errorMessage: String) {
        print(errorMessage)
    }
    func noGoogleUserSignedIn() {
        if let _ = AuthUserService.manager.getCurrentUser() {
            self.currentlyLoggedIn = true
        }
    }
}

