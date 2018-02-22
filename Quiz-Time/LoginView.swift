//
//  LoginView.swift
//  Quiz-Time
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit
import GoogleSignIn

class LoginView: UIView {

    public lazy var appTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Quiz Time"
        label.font = UIFont(name: "Chalkduster", size: 48)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        label.textColor = UIColor.lightPurple
        return label
    }()
    
    public lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:"
        label.textAlignment = .left
        label.font = UIFont(name: "Chalkduster", size: 16)
        label.textColor = UIColor.lightPurple
        label.setContentHuggingPriority(UILayoutPriority(253), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        return label
    }()
    
    public lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email..."
        return textField
    }()
    
    public lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password:"
        label.textAlignment = .left
        label.font = UIFont(name: "Chalkduster", size: 16)
        label.textColor = UIColor.lightPurple
        label.setContentHuggingPriority(UILayoutPriority(253), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        return label
    }()
    
    public lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password..."
        textField.isSecureTextEntry = true
        return textField
    }()
    
    public lazy var emailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fill
        return stackView
    }()
    
    public lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fill
        return stackView
    }()
    
    public lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.buttonBlue, for: .normal)
        return button
    }()
    
    public lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(UIColor.buttonBlue, for: .normal)
        return button
    }()
    
    public lazy var googleSignInButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.colorScheme = .light
        button.style = GIDSignInButtonStyle.wide
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setUpViews()
    }
    
    private func setUpViews() {
        setUpAppTitleLabel()
        setUpEmailStackView()
        setUpPasswordStackView()
        setUpLoginButton()
        setUpCreateButton()
        setUpGoogleSignInButton()
    }
    
    private func setUpAppTitleLabel() {
        self.addSubview(appTitleLabel)
        
        appTitleLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self).inset(80)
        }
    }
    
    private func setUpEmailStackView() {
        self.addSubview(emailStackView)
        
        emailStackView.snp.makeConstraints { (make) in
            make.top.equalTo(appTitleLabel.snp.bottom).offset(80)
            make.leading.trailing.equalTo(self).inset(50)
        }
    }
    
    private func setUpPasswordStackView() {
        self.addSubview(passwordStackView)
        
        passwordStackView.snp.makeConstraints { (make) in
            make.top.equalTo(emailStackView.snp.bottom).offset(10)
            make.width.equalTo(emailStackView.snp.width)
            make.centerX.equalTo(emailStackView.snp.centerX)
        }
    }
    
    private func setUpLoginButton() {
        self.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordStackView.snp.bottom).offset(40)
            make.centerX.equalTo(passwordStackView.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.20)
        }
        
        loginButton.layer.borderColor = UIColor.lightPurple.cgColor
        loginButton.layer.borderWidth = 1.0
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 10
    }
    
    private func setUpCreateButton() {
        self.addSubview(createButton)
        
        createButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.centerX.equalTo(loginButton.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.40)
        }
        
        createButton.layer.borderColor = UIColor.lightPurple.cgColor
        createButton.layer.borderWidth = 1.0
        createButton.layer.masksToBounds = true
        createButton.layer.cornerRadius = 10
    }
    
    private func setUpGoogleSignInButton() {
        self.addSubview(googleSignInButton)
        
        googleSignInButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(passwordStackView.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-40)
        }
    }
}
