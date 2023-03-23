//
//  UserDetails.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import Foundation

struct UserDetailsResponse: Codable {
    let status: String
    let data: UserDetails
}

struct UserDetails: Codable, Identifiable, Equatable {
    let id: String
    let firstName: String
    let lastName: String
    let age: Int
    let gender: String
    let country: String
}
