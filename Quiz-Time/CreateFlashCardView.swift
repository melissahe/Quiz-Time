//
//  CreateFlashCardView.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class CreateFlashCardView: UIScrollView {

    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add A Flashcard"
        label.font = UIFont(name: "Chalkduster", size: 30)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        label.textColor = UIColor.lightPurple
        return label
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category:"
        label.textColor = .lightPurple
        label.font = UIFont(name: "Chalkduster", size: 20)
        label.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        return label
    }()
    
    lazy var categoryListButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pick A Category", for: .normal)
        button.setTitleColor(UIColor.buttonBlue, for: .normal)
        button.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        return button
    }()
    
    lazy var categoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "categoryCell")
        tableView.isHidden = true
        return tableView
    }()
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Question:"
        label.textColor = .lightPurple
        label.font = UIFont(name: "Chalkduster", size: 20)
        label.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        return label
    }()
    
    lazy var questionTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.placeholder = "Question here..."
        textField.isUserInteractionEnabled = true
        textField.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        return textField
    }()
    
    lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.text = "Answer:"
        label.textColor = .lightPurple
        label.font = UIFont(name: "Chalkduster", size: 20)
        label.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        return label
    }()
    
    lazy var answerTextView: UITextView = {
        let textView = UITextView()
        return textView
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
        setUpContentView()
        setUpTitleLabel()
        setUpCategoryLabel()
        setUpCategoryListButton()
        setUpCategoryTableView()
        setUpQuestionLabel()
        setUpQuestionTextField()
        setUpAnswerLabel()
        setUpAnswerTextView()
    }
    
    private func setUpContentView() {
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
            make.width.equalTo(self.snp.width)
            make.center.equalTo(self.snp.center)
        }
    }
    
    private func setUpTitleLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalTo(contentView).inset(40)
        }
    }
    
    private func setUpCategoryLabel() {
        contentView.addSubview(categoryLabel)
        
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(contentView).offset(20)
        }
    }
    
    private func setUpCategoryListButton() {
        contentView.addSubview(categoryListButton)
        
        categoryListButton.snp.makeConstraints { (make) in
            make.leading.equalTo(categoryLabel.snp.trailing).offset(5)
            make.centerY.equalTo(categoryLabel.snp.centerY)
            make.trailing.equalTo(contentView).offset(-20)
        }
        
        categoryListButton.layer.masksToBounds = true
        categoryListButton.layer.borderWidth = 1.0
        categoryListButton.layer.borderColor = UIColor.lightPurple.cgColor
    }
    
    private func setUpCategoryTableView() {
        contentView.addSubview(categoryTableView)
        
        categoryTableView.snp.makeConstraints { (make) in
            make.height.width.equalTo(categoryListButton)
            make.center.equalTo(categoryListButton)
        }
    }
    
    private func setUpQuestionLabel() {
        contentView.addSubview(questionLabel)
        
        questionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView).offset(20)
        }
    }
    
    private func setUpQuestionTextField() {
        contentView.addSubview(questionTextField)
        
        questionTextField.snp.makeConstraints { (make) in
            make.leading.equalTo(questionLabel.snp.trailing).offset(5)
            make.trailing.equalTo(contentView).offset(-20)
            make.height.centerY.equalTo(questionLabel)
        }
    }
    
    private func setUpAnswerLabel() {
        contentView.addSubview(answerLabel)
        
        answerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(questionLabel.snp.bottom).offset(10)
            make.leading.equalTo(questionLabel.snp.leading)
        }
    }
    
    private func setUpAnswerTextView() {
        contentView.addSubview(answerTextView)
        
        answerTextView.snp.makeConstraints { (make) in
            make.top.equalTo(answerLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(contentView).inset(20)
            make.height.lessThanOrEqualTo(contentView).multipliedBy(0.40)
            make.bottom.equalTo(contentView).offset(-40)
        }
        
        answerTextView.layer.masksToBounds = true
        answerTextView.layer.cornerRadius = 10
        answerTextView.layer.borderWidth = 1
        answerTextView.layer.borderColor = UIColor.lightPurple.cgColor
    }
}
