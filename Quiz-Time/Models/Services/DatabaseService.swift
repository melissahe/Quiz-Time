//
//  DatabaseService.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DatabaseService: NSObject {
    override init() {
        self.database = Database.database()
        self.reference = database.reference()
        self.flashcardsRef = reference.child("flashcards")
        self.categoriesRef = reference.child("categories")
        super.init()
    }
    let database: Database!
    let reference: DatabaseReference!
    let flashcardsRef: DatabaseReference!
    let categoriesRef: DatabaseReference!
    
    public weak var delegate: DatabaseServiceDelegate?
}
