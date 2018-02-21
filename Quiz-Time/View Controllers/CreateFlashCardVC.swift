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
    private let createFlashCardView = CreateFlashCardView()
    
    private var notificationCenter: NotificationCenter!
    
    private var keyboardIsShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNotifications()
        setUpNavigation()
        setUpViews()
        setUpGestures()
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
    }
    
    private func setUpGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped))
        
        createFlashCardView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func scrollViewTapped() {
        self.view.endEditing(true)
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
        
        createFlashCardView.contentInset = UIEdgeInsets(top: contentInset.top, left: contentInset.left, bottom: contentInset.bottom + keyboardSize.height, right: contentInset.right)
        createFlashCardView.scrollIndicatorInsets = createFlashCardView.contentInset
        createFlashCardView.setContentOffset(CGPoint(x: 0, y: keyboardSize.height / 2), animated: true)
        
        keyboardIsShown = true
    }
    
    @objc private func keyboardWillHide(sender: Notification) {
        guard let userInfo = sender.userInfo, let keyboardRect = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else {
            print("couldn't get keyboard rect")
            return
        }
        
        print(keyboardRect)
        
        let keyboardSize = keyboardRect.size
        let contentInset = createFlashCardView.contentInset
        
        createFlashCardView.contentInset = UIEdgeInsets(top: contentInset.top, left: contentInset.left, bottom: contentInset.bottom - keyboardSize.height, right: contentInset.right)
        createFlashCardView.scrollIndicatorInsets = createFlashCardView.contentInset
        keyboardIsShown = false
    }
    
    @objc private func addCardButtonPressed() {
        //to do
    }
    
    @objc private func resetButtonPressed() {
        
    }
}

extension CreateFlashCardVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
