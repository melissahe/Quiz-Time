//
//  CreateFlashCardVC.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SVProgressHUD
import NotificationCenter

class CreateFlashCardVC: UIViewController {
    public let createFlashCardView = CreateFlashCardView()
    private var notificationCenter: NotificationCenter!
    private var keyboardIsShown = false
    private var categories: [Category] = [] {
        didSet {
            createFlashCardView.categoryTableView.reloadData()
        }
    }
    private var currentUserID: String {
        return AuthUserService.manager.getCurrentUser()!.uid
    }
    
    private var databaseService = DatabaseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseService.delegate = self
        setUpNotifications()
        setUpNavigation()
        setUpViews()
        setUpGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseService.getAllCategories(fromUserID: currentUserID) { (categories) in
            if let categories = categories {
                self.categories = categories
            }
        }
    }
    
    private func setUpNotifications() {
        self.notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func setUpNavigation() {
        self.navigationItem.title = "Create Flashcard"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCardButtonPressed))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(resetButtonPressed))
    }
    
    private func setUpViews() {
        self.view.addSubview(createFlashCardView)
        
        createFlashCardView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
            make.center.equalTo(self.view.snp.center)
        }
        
        createFlashCardView.questionTextField.delegate = self
        createFlashCardView.categoryTableView.delegate = self
        createFlashCardView.categoryTableView.dataSource = self
        createFlashCardView.categoryListButton.addTarget(self, action: #selector(categoryListButtonPressed), for: .touchUpInside)
    }
    
    private func setUpGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped))
        tapGesture.cancelsTouchesInView = false
        createFlashCardView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func scrollViewTapped() {
        self.view.endEditing(true)
        createFlashCardView.categoryTableView.isHidden = true
    }
    
    @objc private func categoryListButtonPressed() {
        if createFlashCardView.categoryTableView.isHidden {
            createFlashCardView.categoryTableView.isHidden = false
        } else {
            createFlashCardView.categoryTableView.isHidden = true
        }
    }
    
    @objc private func keyboardWillShow(sender: Notification) {
        guard let userInfo = sender.userInfo, let keyboardRect = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else {
            print("couldn't get keyboard rect")
            return
        }
        if keyboardIsShown {
            return
        }
        print(keyboardRect)
        
        let keyboardSize = keyboardRect.size
        let contentInset = createFlashCardView.contentInset
        
        createFlashCardView.contentInset = UIEdgeInsets(top: contentInset.top, left: contentInset.left, bottom: contentInset.bottom + (keyboardSize.height * 0.90), right: contentInset.right)
        createFlashCardView.scrollIndicatorInsets = createFlashCardView.contentInset
        createFlashCardView.setContentOffset(CGPoint(x: 0, y: keyboardSize.height / 2), animated: true)
        
        keyboardIsShown = true
    }
    
    @objc private func keyboardWillHide(sender: Notification) {
        guard let userInfo = sender.userInfo, let keyboardRect = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else {
            print("couldn't get keyboard rect")
            return
        }
        if !keyboardIsShown {
            return
        }
        print(keyboardRect)
        
        let keyboardSize = keyboardRect.size
        let contentInset = createFlashCardView.contentInset
        
        createFlashCardView.contentInset = UIEdgeInsets(top: contentInset.top, left: contentInset.left, bottom: contentInset.bottom - (keyboardSize.height * 0.90), right: contentInset.right)
        createFlashCardView.scrollIndicatorInsets = createFlashCardView.contentInset
        keyboardIsShown = false
    }
    
    @objc private func addCardButtonPressed() {
        if !createFlashCardView.categoryTableView.isHidden {
            let errorAlert = Alert.createErrorAlert(withMessage: "Smh please select a category first!!", andCompletion: nil)
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        guard let categoryName = createFlashCardView.categoryListButton.titleLabel?.text, categoryName != "Pick A Category" else {
            let errorAlert = Alert.createErrorAlert(withMessage: "Smh please select a category first!!", andCompletion: nil)
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        guard let question = createFlashCardView.questionTextField.text, !question.isEmpty else {
            let errorAlert = Alert.createErrorAlert(withMessage: "You can't have an empty question!!", andCompletion: nil)
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        guard let answer = createFlashCardView.answerTextView.text, !answer.isEmpty else {
            let errorAlert = Alert.createErrorAlert(withMessage: "You can't have an answer question!!", andCompletion: nil)
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        SVProgressHUD.show()
        let flashcard = Flashcard(question: question, answer: answer, category: categoryName, userID: currentUserID)
        databaseService.addFlashcard(flashcard)
    }
    
    @objc private func resetButtonPressed() {
        let alert = Alert.createAlert(withTitle: "Ooooohhh noooo!!!!", andMessage: "😱😱😱\nAre you sure you wanna erase everything??!!!?!????\n😱😱😱")
        Alert.addAction(withTitle: "Oml yes!! 😑😑😑", style: .default, andCompletion: { [weak self] (_) in
            self?.createFlashCardView.answerTextView.text = nil
            self?.createFlashCardView.questionTextField.text = nil
        }, toAlertController: alert)
        Alert.addAction(withTitle: "OMG no!!!!! 😱😱😱", style: .default, andCompletion: nil, toAlertController: alert)
        self.present(alert, animated: true, completion: nil)
    }
}

extension CreateFlashCardVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CreateFlashCardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if categories.isEmpty {
            createFlashCardView.categoryTableView.isHidden = true
            return
        }
        let category = categories[indexPath.row]
        createFlashCardView.categoryListButton.setTitle(category.name, for: .normal)
        createFlashCardView.categoryTableView.isHidden = true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(categories.count, 1)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return createFlashCardView.categoryListButton.frame.size.height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        if categories.isEmpty {
            cell.categoryTitleLabel.text = "No categories added"
            return cell
        }
        
        let currentCategory = categories[indexPath.row]
        cell.categoryTitleLabel.text = currentCategory.name
        
        return cell
    }
}
