//
//  Flashcard.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation

struct Flashcard: Codable {
    let question: String
    let answer: String
    let category: String
    var flashcardID: String = "tbd"
    var score: Int = 0
    let userID: String
    var timestamp: Double = Date.timeIntervalSinceReferenceDate
    
    init(question: String, answer: String, category: String, userID: String) {
        self.question = question
        self.answer = answer
        self.category = category
        self.userID = userID
    }
    
    init?(flashcardDict: [String : Any]) {
        guard let question = flashcardDict["question"] as? String else {
            print("couldn't get question")
            return nil
        }
        guard let answer = flashcardDict["answer"] as? String else {
            print("couldn't get answer")
            return nil
        }
        guard let category = flashcardDict["category"] as? String else {
            print("couldn't get category")
            return nil
        }
        guard let flashcardID = flashcardDict["flashcardID"] as? String else {
            print("couldn't get flashcardID")
            return nil
        }
        guard let userID = flashcardDict["userID"] as? String else {
            print("couldn't get userID")
            return nil
        }
        guard let timestamp = flashcardDict["timestamp"] as? Double else {
            print("couldn't get timestamp")
            return nil
        }
        self.question = question
        self.answer = answer
        self.category = category
        self.flashcardID = flashcardID
        self.userID = userID
        self.timestamp = timestamp
    }
    
    func toJSON() -> Any {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(self)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        return json
    }
}

extension Array where Element == Flashcard {
    func sortedByTimestamp() -> [Flashcard] {
        return self.sorted {$0.timestamp < $1.timestamp}
    }
    func filterByCategory(categoryName: String) -> [Flashcard] {
        return self.filter{$0.category == categoryName}
    }
}
