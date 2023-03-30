//
//  PersonListTEST.swift
//  TestIOSTests
//
//  Created by Developer on 29.03.2023.
//

@testable import TestIOS
import XCTest

class PersonalListViewModelTest: XCTestCase {
    
    func testNavigationsDetail() {
        let user = UserDetails(id: "1", firstName: "Jon", lastName: "Smith", age: 17, gender: "male", country: "Canada")
        let sut = PersonListViewModel(userService: UserServiceMock())
        var result: PersonListViewModel.Result?
        sut.onResult = { value in
            result = value
        }
        sut.navigationDetail(user: user)
        XCTAssertEqual(result, .navigationDetail(user: user))
    }
    
    func testFetchPeople() {
        let userMock = UserServiceMock()
        let sut = PersonListViewModel(userService: userMock)
        userMock.fetchPeople()
        userMock.fetchPersonDetails(withId: "1")
        sut.fetchPeople()
        XCTAssertFalse(sut.isAlerting)
    }
}
