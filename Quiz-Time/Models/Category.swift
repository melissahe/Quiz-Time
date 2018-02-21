//
//  Category.swift
//  Quiz-Time
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation

struct Category: Codable, Equatable {
    
    let name: String
    let userID: String
    
    init(name: String, userID: String) {
        self.name = name
        self.userID = userID
    }
    
    static func ==(lhs: Category, rhs: Category) -> Bool {
        return lhs.name == rhs.name
    }
    
    init?(categoryDict: [String : Any]) {
        guard let name = categoryDict["name"] as? String else {
            print("couldn't get name")
            return nil
        }
        guard let userID = categoryDict["userID"] as? String else {
            print("couldn't get userID")
            return nil
        }
        self.name = name
        self.userID = userID
    }
    
    func toJSON() -> Any {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(self)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        return json
    }
}

extension Array where Element == Category {
    func sortedAlphabetically() -> [Category] {
        return self.sorted {$0.name.lowercased() < $1.name.lowercased()}
    }
}
