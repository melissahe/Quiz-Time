//
//  Quiz_TimeTests.swift
//  Quiz-TimeTests
//
//  Created by C4Q on 2/20/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import XCTest
import Firebase
import FirebaseAuth
import FirebaseDatabase
@testable import Quiz_Time

class Quiz_TimeTests: XCTestCase, DatabaseServiceDelegate {
    private var flashcardAdded: Bool!
    private var categoryAdded: Bool!
    private var flashcardExpectation: XCTestExpectation!
    private var categoryExpectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        //sign up/in for auth
        flashcardAdded = false
        categoryAdded = false
        FirebaseApp.configure()
    }

    override func tearDown() {
        flashcardAdded = nil
        categoryAdded = nil
        flashcardExpectation = nil
        categoryExpectation = nil
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
        super.tearDown()
    }
    
    //testing asynchronous function
    func testAddingFlashcardToFirebase() {
        //sign in
        Auth.auth().signIn(withEmail: "melissahe@ac.c4q.nyc", password: "abc123") { [weak self] (_, error) in
            if let error = error {
                print(error)
                Auth.auth().createUser(withEmail: "melissahe@ac.c4q.nyc", password: "abc123", completion: { [weak self] (_, error) in
                    if let error = error {
                        //possible lack of internet
                        print(error)
                        XCTFail("Could not log in")
                    } else {
                        self?.checkFlashcardExpectation()
                    }
                })
            } else {
                self?.checkFlashcardExpectation()
            }
            
        }
    }
    
    private func checkFlashcardExpectation() {
        let testFlashCard = Flashcard(question: "test", answer: "test", category: "test", userID: "test")
        
        //set expectation
        self.flashcardExpectation = self.expectation(description: "Add Flashcard")
        
        //perform async function
        let databaseService = DatabaseService()
        databaseService.delegate = self
        databaseService.addFlashcard(testFlashCard)
        
        //wait for results - 100 seconds
        wait(for: [(flashcardExpectation)!], timeout: 100)
        XCTAssertEqual(flashcardAdded, true)
    }
    
    //delegate function
    func didAddFlashcard(_ databaseService: DatabaseService) {
        self.flashcardAdded = true
        self.flashcardExpectation.fulfill()
    }
    
    func testAddingCategoryToFirebase() {
        //sign in
        Auth.auth().signIn(withEmail: "melissahe@ac.c4q.nyc", password: "abc123") { [weak self] (_, error) in
            if let error = error {
                print(error)
                Auth.auth().createUser(withEmail: "melissahe@ac.c4q.nyc", password: "abc123", completion: { (_, error) in
                    if let error = error {
                        //possible lack of internet
                        print(error)
                    } else {
                        self?.checkCategoryExpectation()
                    }
                })
            } else {
                self?.checkCategoryExpectation()
            }
        }
        
    }
    
    func checkCategoryExpectation() {
        let testCategory = Quiz_Time.Category(name: "test", userID: "test")
        
        //set expectation
        categoryExpectation = expectation(description: "Add Category")
        
        //perform async function
        let databaseService = DatabaseService()
        databaseService.delegate = self
        databaseService.addCategory(testCategory)
        
        //wait for results - 100 seconds
        wait(for: [categoryExpectation], timeout: 100)
        XCTAssertEqual(categoryAdded, true)
    }
    
    func didAddCategory(_ databaseService: DatabaseService) {
        categoryAdded = true
    }
    
}
