//
//  CreateAccountView.swift
//  Quiz-Time
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

class CreateAccountView: UIView {

    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "dismissButtonIcon"), for: .normal)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Account"
        label.font = UIFont(name: "Chalkduster", size: 40)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        label.textColor = UIColor.lightPurple
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:"
        label.textAlignment = .left
        label.font = UIFont(name: "Chalkduster", size: 16)
        label.textColor = UIColor.lightPurple
        label.setContentHuggingPriority(UILayoutPriority(253), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email..."
        return textField
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password:"
        label.textAlignment = .left
        label.font = UIFont(name: "Chalkduster", size: 16)
        label.textColor = UIColor.lightPurple
        label.setContentHuggingPriority(UILayoutPriority(253), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password..."
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var emailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(UIColor.buttonBlue, for: .normal)
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
        setUpDismissButton()
        setUpTitleLabel()
        setUpEmailStackView()
        setUpPasswordStackView()
        setUpCreateButton()
    }
    
    private func setUpDismissButton() {
        self.addSubview(dismissButton)
        
        dismissButton.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(8)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(8)
        }
    }
    
    private func setUpTitleLabel() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dismissButton).offset(80)
            make.leading.trailing.equalTo(self).inset(20)
        }
    }
    
    private func setUpEmailStackView() {
        self.addSubview(emailStackView)
        
        emailStackView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(80)
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
    
    private func setUpCreateButton() {
        self.addSubview(createButton)
        
        createButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordStackView.snp.bottom).offset(40)
            make.width.equalTo(self).multipliedBy(0.40)
            make.centerX.equalTo(passwordStackView.snp.centerX)
        }
        
        createButton.layer.borderColor = UIColor.lightPurple.cgColor
        createButton.layer.borderWidth = 1.0
        createButton.layer.masksToBounds = true
        createButton.layer.cornerRadius = 10
    }
}
