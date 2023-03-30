//
//  UserServiceMock.swift
//  TestIOSTests
//
//  Created by Developer on 29.03.2023.
//

import Foundation
import Combine
import CryptoKit

@testable import TestIOS
import XCTest
class UserServiceMock: UserServise {
    var user = UserDetails(id: "", firstName: "", lastName: "", age: 1, gender: "", country: "")
    var userIDs = ["1", "2"]
    
    func fetchPersonDetails(withId id: String) -> AnyPublisher<TestIOS.UserDetails, Error> {
        Just(TestIOS.UserDetails(id: user.id, firstName: user.firstName, lastName: user.lastName, age: user.age, gender: user.gender, country: user.country))
        
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func fetchPeople() -> AnyPublisher<UsersList, Error> {
        Just(TestIOS.UsersList(userIDs: userIDs))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
