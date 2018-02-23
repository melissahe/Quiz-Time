//
//  DatabaseServiceDelegate.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

@objc protocol DatabaseServiceDelegate: class {
    @objc optional func didAddFlashcard(_ databaseService: DatabaseService)
    @objc optional func didFailAddingFlashcard(_ databaseService: DatabaseService, errorMessage: String)
    @objc optional func didAddCategory(_ databaseService: DatabaseService)
    @objc optional func didFailAddingCategory(_ databaseService: DatabaseService, errorMessage: String)
}
