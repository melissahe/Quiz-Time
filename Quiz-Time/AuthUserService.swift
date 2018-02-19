//
//  AuthUserService.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthUserService {
    private init() {
        self.auth = Auth.auth()
    }
    static let manager = AuthUserService()
    private let auth: Auth!
    public weak var delegate: AuthUserServiceDelegate?
    
    public func createAccount(withEmail email: String, andPassword password: String, completion: @escaping (User?, Error?) -> Void) {
        auth.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                completion(nil, error)
            } else if let user = user {
                completion(user, nil)
            }
        }
    }
    
    public func signIn(withCredentials credentials: AuthCredential) {
        auth.signIn(with: credentials) { (user, error) in
            if let error = error {
                print("couldn't sign in!!")
                self.delegate?.didFailSignInWithGoogle(self, errorMessage: error.localizedDescription)
            } else if let user = user {
                print("signed in!!!!!")
                self.delegate?.didSignInWithGoogle(self, user: user)
            }
        }
    }
    
    public func signIn(withEmail email: String, andPassword password: String, completion: @escaping (User?, Error?) -> Void) {
        auth.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("couldn't sign in!")
                completion(nil, error)
            } else if let user = user {
                print("signed in!!!!!")
                completion(user, nil)
            }
        }
    }
    
    public func getCurrentUser() -> User? {
        return auth.currentUser
    }
}
