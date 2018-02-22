//
//  CreateFlashCardVC+DatabaseService.swift
//  Quiz-Time
//
//  Created by C4Q on 2/21/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import SVProgressHUD

extension CreateFlashCardVC: DatabaseServiceDelegate {
    func didAddFlashcard(_ databaseService: DatabaseService) {
        SVProgressHUD.dismiss()
        let successAlert = Alert.createSuccessAlert(withMessage: "Added a flashcard!!!", andCompletion: { [weak self] _ in
            self?.createFlashCardView.questionTextField.text = nil
            self?.createFlashCardView.answerTextView.text = nil
        })
        self.present(successAlert, animated: true, completion: nil)
    }
    func didFailAddingFlashcard(_ databaseService: DatabaseService, errorMessage: String) {
        SVProgressHUD.dismiss()
        let errorAlert = Alert.createErrorAlert(withMessage: "Couldn't add the flashcard!! Please check your internet connection smh.", andCompletion: nil)
        self.present(errorAlert, animated: true, completion: nil)
    }
}
