//
//  CategoryTableViewCell.swift
//  Quiz-Time
//
//  Created by C4Q on 2/20/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.buttonBlue
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        self.contentView.addSubview(categoryTitleLabel)
        
        categoryTitleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }
    
}
