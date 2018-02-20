//
//  DatabaseService+Add.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation

extension DatabaseService {
    public func addFlashcard(_ flashcard: Flashcard) {
        var flashcard = flashcard
        let flashcardRef = flashcardsRef.child(flashcard.userID).childByAutoId()
        flashcard.flashcardID = flashcardRef.key
        let flashcardJSON = flashcard.toJSON()
        flashcardRef.setValue(flashcardJSON) { (error, _) in
            if let error = error {
                self.delegate?.didFailAddingFlashcard?(self, errorMessage: error.localizedDescription)
            } else {
                self.delegate?.didAddFlashcard?(self)
            }
        }
    }
    public func addCategory(_ category: Category) {
        var category = category
        let categoryRef = categoriesRef.child(category.userID).childByAutoId()
        category.categoryID = categoriesRef.key
        let categoryJSON = category.toJSON()
        categoryRef.setValue(categoryJSON) { (error, _) in
            if let error = error {
                self.delegate?.didFailAddingCategory?(self, errorMessage: error.localizedDescription)
            } else {
                self.delegate?.didAddCategory?(self)
            }
        }
    }
}
