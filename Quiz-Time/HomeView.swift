//
//  HomeView.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pick a category!"
        label.font = UIFont(name: "Chalkduster", size: 32)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        label.textColor = UIColor.lightPurple
        return label
    }()
    
    public lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category:"
        label.font = UIFont(name: "Chalkduster", size: 20)
        label.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        label.textColor = UIColor.lightPurple
        return label
    }()
    
    public lazy var categoryListButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pick A Category", for: .normal)
        button.setTitleColor(UIColor.buttonBlue, for: .normal)
        button.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        return button
    }()
    
    public lazy var categoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "categoryCell")
        tableView.isHidden = true
        tableView.backgroundColor = .white
        return tableView
    }()
    
    public lazy var quizButton: UIButton = {
        let button = UIButton()
        button.setTitle("Quiz Me!!", for: .normal)
        button.setTitleColor(UIColor.buttonBlue, for: .normal)
        return button
    }()
    
    public lazy var addCategoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add A Category", for: .normal)
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
        setUpTitleLabel()
        setUpCategoryLabel()
        setUpCategoryListButton()
        setUpQuizButton()
        setUpAddCategoryButton()
        setUpCategoryTableView()
    }
    
    private func setUpTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalTo(self).inset(40)
        }
    }
    
    private func setUpCategoryLabel() {
        self.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalTo(self).offset(20)
        }
    }
    
    private func setUpCategoryListButton() {
        self.addSubview(categoryListButton)
        categoryListButton.snp.makeConstraints { (make) in
            make.leading.equalTo(categoryLabel.snp.trailing).offset(5)
            make.centerY.equalTo(categoryLabel.snp.centerY)
            make.trailing.equalTo(self).offset(-20)
        }
        categoryListButton.layer.masksToBounds = true
        categoryListButton.layer.borderWidth = 1.0
        categoryListButton.layer.borderColor = UIColor.lightPurple.cgColor
    }
    
    private func setUpCategoryTableView() {
        self.addSubview(categoryTableView)
        categoryTableView.snp.makeConstraints { (make) in
            make.width.equalTo(categoryListButton)
            make.top.equalTo(categoryListButton.snp.bottom)
            make.centerX.equalTo(categoryListButton.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.30)
        }
        categoryTableView.layer.masksToBounds = true
        categoryTableView.layer.borderWidth = 1
        categoryTableView.layer.borderColor = UIColor.lightPurple.cgColor
    }
    
    private func setUpQuizButton() {
        self.addSubview(quizButton)
        quizButton.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLabel.snp.bottom).offset(40)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.30)
        }
        quizButton.layer.masksToBounds = true
        quizButton.layer.cornerRadius = 10
        quizButton.layer.borderWidth = 1
        quizButton.layer.borderColor = UIColor.lightPurple.cgColor
    }
    
    private func setUpAddCategoryButton() {
        self.addSubview(addCategoryButton)
        addCategoryButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-150)
            make.centerX.equalTo(quizButton.snp.centerX)
            make.width.equalTo(self).multipliedBy(0.50)
        }
        addCategoryButton.layer.masksToBounds = true
        addCategoryButton.layer.cornerRadius = 10
        addCategoryButton.layer.borderColor = UIColor.lightPurple.cgColor
        addCategoryButton.layer.borderWidth = 1
    }
}
