//
//  UserList.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import Foundation

struct UsersList: Codable {
    let userID: [String]
    
    enum CodingKeys: String, CodingKey {
        case userID = "data"
    }
}
