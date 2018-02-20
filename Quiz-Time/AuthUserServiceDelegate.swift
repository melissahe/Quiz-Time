//
//  AuthUserServiceDelegate.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol AuthUserServiceDelegate: class {
    func didSignInWithGoogle(_ authUserService: AuthUserService, user: User)
    func didFailSignInWithGoogle(_ authUserService: AuthUserService, errorMessage: String)
    func noGoogleUserSignedIn()
}
