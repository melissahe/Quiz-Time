//
//  CardCollectionViewCell.swift
//  Quiz-Time
//
//  Created by C4Q on 2/22/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

class CardCollectionViewCell: UICollectionViewCell {
    public enum CardType {
        case question
        case answer
    }
    
    public var cardType: CardType = .question
    
    public lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Georgia", size: 20)
        label.textColor = UIColor.plum
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    public lazy var pageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Georgia", size: 16)
        label.textColor = UIColor.plum
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor.plum.cgColor
        contentView.layer.borderWidth = 1.0
        setUpViews()
    }
    
    private func setUpViews() {
        setUpTextLabel()
        setUpPageLabel()
    }
    
    private func setUpTextLabel() {
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView).inset(10)
        }
    }
    
    private func setUpPageLabel() {
        contentView.addSubview(pageLabel)
        pageLabel.snp.makeConstraints { (make) in
            make.trailing.bottom.equalTo(contentView).offset(-10)
        }
    }
}
