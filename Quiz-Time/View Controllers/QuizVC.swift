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
            quizView.cardCollectionView.reloadData()
        }
    }
    
    private var currentRow: Int = 0
    
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
    
    private func disableButtons() {
        quizView.wrongButton.isEnabled = false
        quizView.wrongButton.isSelected = true
        quizView.rightButton.isEnabled = false
        quizView.rightButton.isSelected = true
    }
    
    private func enableButtons() {
        quizView.wrongButton.isEnabled = true
        quizView.wrongButton.isSelected = false
        quizView.rightButton.isEnabled = true
        quizView.rightButton.isSelected = false
    }
    
    private func allFlashcardsUsed() -> Bool {
        for flashcard in flashcards {
            if flashcard.score == .unanswered {
                return false
            }
        }
        return true
    }
    
    private func presentFinishAlert() {
        let scorePercent = (Double(score) / Double(flashcards.count)) * 100
        let roundedPercentString = String.init(format: "%.2f", scorePercent)
        let finishAlert = Alert.createAlert(withTitle: "Quiz Over!!!!! LOL", andMessage: "Your score was \(score)/\(flashcards.count)...\nThat's \(roundedPercentString)% 😂")
        Alert.addAction(withTitle: "Lol okay 😂", style: .default, andCompletion: { [weak self] (_) in
            self?.navigationController?.popToRootViewController(animated: true)
        }, toAlertController: finishAlert)
        self.present(finishAlert, animated: true, completion: nil)
    }
    
    private func moveToNextCell() {
//        if possible, move to the next flashcard
        if let currentCell = quizView.cardCollectionView.visibleCells.first, let indexPath = quizView.cardCollectionView.indexPath(for: currentCell) {
            flashcards[indexPath.row].score = .answered
            if indexPath.row == flashcards.count - 1 {
                return
            }
            let nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            quizView.cardCollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    private func buttonPressed() {
        disableButtons()
        moveToNextCell()
        if allFlashcardsUsed() {
            presentFinishAlert()
        }
    }
    
    @objc private func wrongButtonPressed() {
        buttonPressed()
    }
    
    @objc private func rightButtonPressed() {
        score += 1
        buttonPressed()
    }
}

extension QuizVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //animate flip
        let currentFlashcard = flashcards[indexPath.row]
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell else {
            print("Couldn't get cell")
            return
        }
        let animation = CABasicAnimation(keyPath: "transform.rotation.y")
        animation.fromValue = 0
        animation.toValue = CGFloat.pi / 2
        animation.duration = 0.15
        cell.layer.add(animation, forKey: nil)
        //Completion block for all CAAnimations
        CATransaction.setCompletionBlock {
            switch cell.cardType {
            case .question:
                cell.textLabel.text = currentFlashcard.answer
                cell.cardType = .answer
            case .answer:
                cell.textLabel.text = currentFlashcard.question
                cell.cardType = .question
            }
            animation.fromValue = CGFloat.pi / 2
            animation.toValue = 0
            animation.duration = 0.15
            cell.layer.add(animation, forKey: nil)
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentRow = indexPath.row
        let currentFlashcard = flashcards[indexPath.row]
        switch currentFlashcard.score {
        case .answered:
            disableButtons()
        case .unanswered:
            enableButtons()
        }
    }
}

extension QuizVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}

extension QuizVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashcards.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        let currentFlashcard = flashcards[indexPath.row]
        
        cell.textLabel.text = currentFlashcard.question
        cell.pageLabel.text = (indexPath.row + 1).description
        
        return cell
    }
}
