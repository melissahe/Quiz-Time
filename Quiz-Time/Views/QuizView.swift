//
//  QuizView.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

class QuizView: UIView {
    
     public lazy var numberOfCardsLabel: UILabel = {
        let label = UILabel()
        label.text = "Number Of Cards:"
        label.textColor = UIColor.lightPurple
        label.font = UIFont(name: "Chalkduster", size: 20)
        return label
    }()
    
    public lazy var cardCountLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textColor = UIColor.lightPurple
        label.font = UIFont(name: "Chalkduster", size: 20)
        label.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        return label
    }()
    
    public lazy var cardLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberOfCardsLabel, cardCountLabel])
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    public lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score:"
        label.textColor = UIColor.lightPurple
        label.font = UIFont(name: "Chalkduster", size: 20)
        return label
    }()
    
    public lazy var scoreCountLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textColor = UIColor.lightPurple
        label.font = UIFont(name: "Chalkduster", size: 20)
        label.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        return label
    }()
    
    public lazy var scoreLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [scoreLabel, scoreCountLabel])
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    public lazy var rightButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "rightIcon")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        return button
    }()
    
    public lazy var wrongButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "wrongIcon")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        return button
    }()
    
    public lazy var cardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "cardCell")
        collectionView.backgroundColor = .white
        return collectionView
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
        setUpCardLabelStackView()
        setUpScoreLabelStackView()
        setUpWrongButton()
        setUpRightButton()
        setUpCardCollectionView()
    }
    
    private func setUpCardLabelStackView() {
        self.addSubview(cardLabelStackView)
        cardLabelStackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalTo(self).inset(20)
        }
    }
    
    private func setUpScoreLabelStackView() {
        self.addSubview(scoreLabelStackView)
        scoreLabelStackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.cardLabelStackView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self).inset(20)
        }
    }
    
    private func setUpWrongButton() {
        self.addSubview(wrongButton)
        wrongButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-120)
            make.leading.equalTo(self).offset(40)
            make.height.equalTo(self).multipliedBy(0.15)
        }
        wrongButton.layer.masksToBounds = true
        wrongButton.layer.borderWidth = 1
        wrongButton.layer.borderColor = UIColor.lightPurple.cgColor
        wrongButton.layer.cornerRadius = 10
    }
    
    private func setUpRightButton() {
        self.addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-120)
            make.leading.equalTo(wrongButton.snp.trailing).offset(40)
            make.trailing.equalTo(self).offset(-40)
            make.height.width.equalTo(wrongButton)
        }
        rightButton.layer.masksToBounds = true
        rightButton.layer.borderWidth = 1
        rightButton.layer.borderColor = UIColor.lightPurple.cgColor
        rightButton.layer.cornerRadius = 10
    }
    
    private func setUpCardCollectionView() {
        self.addSubview(cardCollectionView)
        cardCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(scoreLabelStackView.snp.bottom).offset(20)
            make.bottom.equalTo(wrongButton.snp.top).offset(-20)
            make.leading.trailing.equalTo(self).inset(20)
        }
    }
}
