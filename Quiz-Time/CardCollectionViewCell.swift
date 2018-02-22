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

    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Georgia", size: 20)
        label.textColor = UIColor.pinkPurple
        label.numberOfLines = 0
        label.textAlignment = .center
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
        contentView.layer.borderColor = UIColor.pinkPurple.cgColor
        contentView.layer.borderWidth = 1.0
        setUpViews()
    }
    
    private func setUpViews() {
        setUpTextLabel()
    }
    
    private func setUpTextLabel() {
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView).inset(5)
        }
    }
}
