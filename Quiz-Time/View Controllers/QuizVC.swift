//
//  QuizVC.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SVProgressHUD

class QuizVC: UIViewController {
    private let cellSpacing = UIScreen.main.bounds.width * 0.05
    
    private let quizView = QuizView()
    private var categoryName: String!
    private var databaseService = DatabaseService()
    private var currentUserID: String {
        return AuthUserService.manager.getCurrentUser()!.uid
    }
    private var score: Int = 0 {
        didSet {
            quizView.scoreCountLabel.text = "\(score) / \(flashcards.count)"
        }
    }
    
    private var flashcards: [Flashcard] = [] {
        didSet {
            quizView.cardCountLabel.text = flashcards.count.description
            quizView.scoreCountLabel.text = "\(score) / \(flashcards.count)"
            if flashcards.isEmpty {
                let alert = Alert.createAlert(withTitle: "SMH!!!1", andMessage: "You don't have any flashcards!!! 🙄")
                Alert.addAction(withTitle: "Fine... 😒", style: .default, andCompletion: {_ in
                    self.navigationController?.popToRootViewController(animated: true)
                }, toAlertController: alert)
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
    }
    
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
        SVProgressHUD.show()
        databaseService.getAllFlashcards(forUserID: currentUserID, andCategoryName: categoryName) { [weak self] (flashcards) in
            SVProgressHUD.dismiss()
            if let flashcards = flashcards {
                self?.flashcards = flashcards
            } else {
                let alert = Alert.createAlert(withTitle: "Could Not Get Flashcards smh", andMessage: "Either add a flashcard, or check your network connectivity.")
                Alert.addAction(withTitle: "Fine... 😒", style: .default, andCompletion: {_ in
                    self?.navigationController?.popToRootViewController(animated: true)
                }, toAlertController: alert)
                self?.present(alert, animated: true, completion: nil)
                return
            }
        }
    }
    
    private func setUpNavigation() {
        self.navigationItem.title = categoryName
    }
    
    private func setUpViews() {
        self.view.addSubview(quizView)
        
        quizView.cardCollectionView.delegate = self
        quizView.cardCollectionView.dataSource = self
        
        quizView.wrongButton.addTarget(self, action: #selector(wrongButtonPressed), for: .touchUpInside)
        quizView.rightButton.addTarget(self, action: #selector(rightButtonPressed), for: .touchUpInside)
    }
    
    @objc private func wrongButtonPressed() {
        //disable self
        //if possible, move to the next flashcard
        //then re-enable
        //if not possible = last card - calculate score
            //get score from array of flashcards!
    }
    
    @objc private func rightButtonPressed() {
        //disable self
        //if possible, move to the next flashcard
        //then re-enable
        score += 1
        //if not possible = last card - calculate score
    }
}

extension QuizVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //to do - animate flip, switch to answer or question
    }
}

extension QuizVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCells: CGFloat = 1
        let numberOfSpaces: CGFloat = numberOfCells + 1
        let width = (collectionView.frame.width - (numberOfSpaces * cellSpacing)) / numberOfCells
        let height = collectionView.frame.height - (2 * cellSpacing)
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
    }
}

extension QuizVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 //to do - fix
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        
        cell.textLabel.text = "test!!!1"
        
        return cell
    }
}
