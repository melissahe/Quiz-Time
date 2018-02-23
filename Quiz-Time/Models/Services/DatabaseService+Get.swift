//
//  DatabaseService+Get.swift
//  Quiz-Time
//
//  Created by C4Q on 2/20/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DatabaseService {
    func getAllCategories(fromUserID userID: String, completion: @escaping ([Category]?) -> Void) {
        let categoryRef = categoriesRef.child(userID)
        categoryRef.observeSingleEvent(of: .value) { (dataSnapshot) in
            guard let categoriesSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                print("could not get children snapshots")
                completion(nil)
                return
            }
            
            var categories: [Category] = []
            for categorySnapshot in categoriesSnapshot {
                guard let categoryDict = categorySnapshot.value as? [String : Any] else {
                    print("could not get category dict")
                    completion(nil)
                    return
                }
                guard let category = Category(categoryDict: categoryDict) else {
                    print("could not get category")
                    completion(nil)
                    return
                }
                categories.append(category)
            }
            completion(categories.sortedAlphabetically())
        }
    }
    func getAllFlashcards(forUserID userID: String, andCategoryName categoryName: String, completion: @escaping ([Flashcard]?) -> Void) {
        let flashcardRef = flashcardsRef.child(userID)
        flashcardRef.observeSingleEvent(of: .value) { (dataSnapshot) in
            guard let flashcardsSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                print("could not get children snapshots")
                completion(nil)
                return
            }
            
            var flashcards: [Flashcard] = []
            for flashcardSnapshot in flashcardsSnapshot {
                guard let flashcardDict = flashcardSnapshot.value as? [String : Any] else {
                    print("could not get flashcard dict")
                    completion(nil)
                    return
                }
                guard let flashcard = Flashcard(flashcardDict: flashcardDict) else {
                    print("could not get flashcard")
                    completion(nil)
                    return
                }
                
                if flashcard.category != categoryName {
                    continue
                }
                
                flashcards.append(flashcard)
            }
            completion(flashcards.sortedByTimestamp())
        }
    }
}
