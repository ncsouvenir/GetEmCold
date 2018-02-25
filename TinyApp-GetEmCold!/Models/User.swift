//
//  User.swift
//  TinyApp-GetEmCold!
//
//  Created by C4Q on 2/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

struct UserProfile: Codable {
    let userUID: String?
    let userName: String
    //trying to encode the struct into jsonData
    func userToJSON() -> Any? {
        let jsonData = try! JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: jsonData, options: [])
    }
}
