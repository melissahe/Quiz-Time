//
//  CreateCategoryView.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class CreateCategoryView: UIView {

    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category:"
        label.textColor = .lightPurple
        label.font = UIFont(name: "Chalkduster", size: 20)
        label.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        return label
    }()
    
    lazy var categoryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Category..."
        textField.borderStyle = .bezel
        return textField
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
        setUpCategoryLabel()
        setUpCategoryTextField()
    }
    
    private func setUpCategoryLabel() {
        self.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(self).offset(20)
        }
    }
    
    private func setUpCategoryTextField() {
        self.addSubview(categoryTextField)
        categoryTextField.snp.makeConstraints { (make) in
            make.leading.equalTo(categoryLabel.snp.trailing).offset(5)
            make.trailing.equalTo(self).offset(-20)
            make.height.centerY.equalTo(categoryLabel)
        }
    }
}
