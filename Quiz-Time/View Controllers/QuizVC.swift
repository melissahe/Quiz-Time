//
//  QuizVC.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class QuizVC: UIViewController {

    private let quizView = QuizView()
    private var categoryName: String!
    
    init(withCategory categoryName: String) {
        self.categoryName = categoryName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        setUpViews()
    }
    
    private func setUpNavigation() {
        self.navigationItem.title = categoryName
    }
    
    private func setUpViews() {
        self.view.addSubview(quizView)
    }

}
