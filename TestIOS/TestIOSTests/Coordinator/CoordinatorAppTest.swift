//
//  CoordinatorAppTest.swift
//  TestIOSTests
//
//  Created by Developer on 29.03.2023.
//

@testable import TestIOS
import XCTest

class CoordinatorAppTest: XCTestCase {
    
    func testGetInfo() {
        let user = UserDetails(id: "1", firstName: "Jon", lastName: "Smith", age: 17, gender: "male", country: "Canada")
        let sut = CoordinatorApp(viewModel: PersonListViewModel(userService: UserServiceImpl()))
        
        sut.viewModel.onResult?(.navigationDetail(user: user))
        XCTAssertNotNil(sut.route)
    }
}
