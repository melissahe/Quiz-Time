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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    init(withCategory categoryName: String) {
        super.init(nibName: nil, bundle: nil)
        //to do
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        self.view.addSubview(quizView)
    }

}
